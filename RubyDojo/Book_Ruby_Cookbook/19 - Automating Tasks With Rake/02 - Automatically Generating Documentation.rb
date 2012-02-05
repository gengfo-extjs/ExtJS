require 'rake/rdoctask'

Rake::RDocTask.new('rdoc') do |t|
  t.rdoc_files.include('README', 'lib/**/*.rb')
  t.main = 'README'
  t.title = "MyLib API documentation"
end
#---
require 'rake/rdoctask'

Rake::RDocTask.new('rdoc') do |t|
  t.rdoc_files.include('README', 'lib/**/*.rb')
  t.main = 'README'
  t.title = "MyLib API documentation"
end

desc 'Upload documentation to RubyForge.'
task 'upload' => 'rdoc' do
    # command(s) to upload html/ and contents to RubyForge
end

desc 'Remove generated and backup files.'
task 'clobber' => 'clobber_rdoc' do
    # command(s) to remove all files ending in ~ or .bak
end
#---
task :default => ['rdoc']
#---
