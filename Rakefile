require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# used this to test new fog / dynect fix
task :records do
  require 'opity'
  s = Time.now
  puts "start: #{s}"
  list = Opity::Resource::Dns.records.all
  e = Time.now
  puts "end:   #{e}"
  list.each do |r|
    puts "record: #{r.inspect}"
  end
  puts "#{Time.now} records: #{list.count} time: #{e.to_i - s.to_i}"
end

task :color do
  require 'colorize'
  puts String.color_matrix
end
