require 'rake/testtask'

Rake::TestTask.new('test') do |t|
  t.pattern = 'test/**/tc_*.rb'
  t.warning = true
end
#---
task "default" => ["test"]
#---
require 'rake/testtask'

lib_dir = File.expand_path('lib')
test_dir = File.expand_path('test')

Rake::TestTask.new("test") do |t|
    t.libs = [lib_dir, test_dir]
    t.pattern = "test/**/tc_*.rb"
    t.warning = true
end
#---
require 'rake/testtask'

Rake::TestTask.new('test-file') do |t|
    t.test_files = ['test/tc_datafile.rb',
                    'test/tc_datafilewriter.rb',
                    'test/tc_datafilereader.rb']
    t.warning = true
end

Rake::TestTask.new('test-console') do |t|
    t.test_files = ['test/tc_console.rb',
                    'test/tc_prettyprinter.rb']
    t.warning = true
end
#---
task 'test' => ['test-file', 'test-console']
#---
