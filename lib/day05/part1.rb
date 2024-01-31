

class Day05
  class << self
    def call
      file = File.read('lib/day05/input1.txt')
      process(file)
    end

    def process(input)
      seed_to_location = Hash.new(nil)
      splitted_input = input.split("\n\n").map {|e| e.split(":") }
      splitted_input.map { |_, v| v.split.map(&:to_i) } => seeds,
                                                           seed_to_soil,
                                                           soil_to_fertilizer,
                                                           fertilizer_to_water,
                                                           water_to_light,
                                                           light_to_temperature,
                                                           temperature_to_humidity,
                                                           humidity_to_location

      mappings_sequence = [seed_to_soil, soil_to_fertilizer, fertilizer_to_water, water_to_light, light_to_temperature, temperature_to_humidity, humidity_to_location]

      seeds.each do |seed|
        seed_to_location[seed] = find_location_for(seed, mappings_sequence)
      end
      seed_to_location.values.min
    end

    def find_location_for(seed, mappings_sequence)
      mappings_sequence.reduce(seed) do |value, mapping|
        convert_number(mapping, value)
      end
    end

    def convert_number(mappings, number)
      target = number
      mappings.each_slice(3) do |destination_start, source_start, range_length|
        if number.between?(source_start, source_start + (range_length - 1))
          target = destination_start + (number - source_start)
        else
          next
        end
      end
      target
    end
  end
end

class Test < Minitest::Test
  def test_day5_part1
    assert_data = <<~DATA
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
    DATA

    assert_equal 35, Day05.process(assert_data)
  end
end
