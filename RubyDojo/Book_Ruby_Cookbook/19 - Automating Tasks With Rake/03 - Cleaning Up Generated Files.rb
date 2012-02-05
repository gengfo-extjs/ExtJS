require 'rake/clean'

# Include the "pkg" and "doc" directories and their contents.
# Include all files ending in ".o" in the current directory
#  and its subdirectories (recursively).
CLOBBER.include('pkg', 'doc', '**/*.o')

# Include InstalledFiles and .config: files created by setup.rb.
# Include temporary files created during test run.
CLEAN.include('InstalledFiles', '.config', 'test/**/*.tmp')
#---
desc 'Remove all object files.'
task 'clobber_objects' do
  rm_f FileList['**/*.o']
end

# Make clobber_objects a prerequisite of the preexisting clobber task
task 'clobber' => 'clobber_objects'
#---
