require 'rake/rdoctask'

html_dir = 'doc/html'
library = 'MyLib'
Rake::RDocTask.new('rdoc') do |t|
  t.rdoc_files.include('README', 'lib/**/*.rb')
  t.main = 'README'
  t.title = "#{library} API documentation"
  t.rdoc_dir = html_dir
end
#---
# Define your RubyForge username and your project's Unix name here:
rubyforge_user = 'user'
rubyforge_project = 'project'

rubyforge_path = "/var/www/gforge-projects/#{rubyforge_project}/"
desc 'Upload documentation to RubyForge.'
task 'upload-docs' => ['rdoc'] do
    sh "scp -r #{html_dir}/* " +
        "#{rubyforge_user}@rubyforge.org:#{rubyforge_path}"
end
#---
rubyforge_path =  "/var/www/gforge-projects/#{rubyforge_project}/rdoc/"
#---
website_dir = 'site'
desc 'Update project website to RubyForge.'
task 'upload-site' do
  sh "scp -r #{website_dir}/* " +
    "#{rubyforge_user}@rubyforge.org:/var/www/gforge-projects/project/"
end

desc 'Update API docs and project website to RubyForge.'
task 'publish' => ['upload-docs', 'upload-site']
#---
