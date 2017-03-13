require 'rake/testtask'
require './lib/driver.rb'
require './lib/rider.rb'
require './lib/trip.rb'
require './lib/file.rb'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = true
  t.test_files = FileList['specs/*_spec.rb']
end

task default: :test
