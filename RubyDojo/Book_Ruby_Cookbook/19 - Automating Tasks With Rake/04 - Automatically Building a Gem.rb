require 'rake/gempackagetask'

# Create a gem specification
gem_spec = Gem::Specification.new do |s|
  s.name = 'docbook'
  s.version = '1.0.0'
  s.summary = 'DocBook formatting program and library.'

  # Files containing Test::Unit test cases.
  s.test_files = FileList['tests/**/*']

  # Executable scripts under the "bin" directory.
  s.executables = ['voc']

  # List of other files to be included.
  s.files = FileList['README', 'ChangeLog', 'lib/**/*.rb']
end

Rake::GemPackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end
#---
