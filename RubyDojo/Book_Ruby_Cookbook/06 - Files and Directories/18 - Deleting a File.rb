FileUtils.touch "doomed_file"
File.exists? "doomed_file"                        # => true
File.delete "doomed_file"
File.exists? "doomed_file"                        # => false
#---
Dir.mkdir "doomed_directory"
File.exists? "doomed_directory"                     # => true
FileUtils.remove_dir "doomed_directory"
File.exists? "doomed_directory"                     # => false
#---
# A hack to make a method used by rm_rf actually available
module FileUtils
  module_function :fu_world_writable?
end

Dir.mkdir "/tmp/doomed_directory"
FileUtils.rm_rf("/tmp/doomed_directory", :secure=>true)
File.exists? "/tmp/doomed_directory"                     # => false
#---
