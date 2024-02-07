class Range
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end

  def intersection(other)
    return nil if (self.max < other.begin or other.max < self.begin)
    [self.begin, other.begin].max..[self.max, other.max].min
  end

  alias_method :&, :intersection
end
input = File.read('lib/day05/input1.txt')
s, *maps = input.split(/\n\n/)
_, *seeds = s.split.map(&:to_i)

maps = maps.map do|m|
  label, *rows = m.split(/\n/)
  rows.map {_1.split.map(&:to_i)}
end

maps = maps.map do |m|
  m2 = m.map do |dest, src, len|
    [
      src,
      src + len - 1,
      dest - src
    ]
  end.sort

  if m2[0][0] != 0
    m2.unshift([0, m2[0][0] - 1, 0])
  else
    m2
  end
end

maps = maps.map do |m|
  src_end = m[-1][1]
  end_cap = [
    src_end + 1,
    src_end + 1_000_000_000_000,
    0
  ]
  m + [end_cap]
end

def convert(page, seed_range)
  page.filter_map do |src_start, src_end, diff|
    if seed_range.overlaps?(src_start...src_end)
      intersection = seed_range & (src_start...src_end)
      rng_start = intersection.begin + diff
      rng_end = intersection.end + diff
      (rng_start..rng_end)
    end
  end
end

current_ranges = Array.new(8) { Set.new }
seeds.each_slice(2).map do |seed_start, len|
  seed_range = (seed_start...seed_start + len)
  current_ranges[0] << seed_range

  maps.each_with_index do |m, i|
    current_ranges[i].each do |current_range|
      current_ranges[i + 1] += convert(m, current_range)
    end
  end
end

p current_ranges.last.map(&:min).min
