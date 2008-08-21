# Rakefile         -*- ruby -*-

require 'rake/testtask'

task :default => [:test]

desc "Run all the tests"
Rake::TestTask.new("test") do |t|
  t.pattern = '*_test.rb'
end
task :test

task :task_info do |t|
  puts t.name
end

task :environment_variable do
  puts ENV['HOME']
end
