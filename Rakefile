require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = false
  t.test_files = FileList['specs/*.rb']
end

task default: :test
