BASE_PATH = './lib'.freeze

begin
  require 'minitest/autorun'
  require 'minitest/reporters'
  require 'pry'
rescue LoadError => e
  puts "#{e}. Installing..."
  # Installing missed gems
  system('gem install pry')
  system('gem install minitest')
  puts 'Installation was completed successfully. Please re-run the program'
  exit
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

%w[day01].each do |dir|
  Dir["#{BASE_PATH}/#{dir}/*.rb"].each { |file| require_relative file }
end

p Day01p2.call
