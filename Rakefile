# Fill me in!
require 'rake/testtask'
# didn't fix my problem
# require_relative 'lib/trip'
# require_relative 'lib/driver'
# require_relative 'lib/rider'
# require_relative 'specs/spec_helper'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = false #was set to 'true' changed it because couldn't get the warnings to go away
  t.test_files = FileList['specs/*_spec.rb']
end

task default: :test
