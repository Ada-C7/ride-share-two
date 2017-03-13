# Fill me in!
require 'rake/testtask'
require_relative 'lib/trip'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = true
  t.test_files = FileList['specs/*_spec.rb']
end

task default: :test
