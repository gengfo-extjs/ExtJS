require 'fileutils'

def backup(from_dir, to_dir, time_format="-%Y%m%d")
  from_path, from_name = File.split(from_dir)
  now = Time.now.strftime(time_format)
  Dir.mkdir(to_dir) unless File.exists? to_dir
  unless File.directory? to_dir
    raise ArgumentError, "Not a directory: #{to_dir}" 
  end
  to = File.versioned_filename(File.join(to_dir, from_name + now))  
  FileUtils.cp_r(from_dir, to, :preserve=>true)
  return to
end

# This method copied from "Backing Up to Versioned Filenames"
class File
  def File.versioned_filename(base, first_suffix=".0")
    suffix = nil
    filename = base
    while File.exists?(filename)
      suffix = (suffix ? suffix.succ : first_suffix)
      filename = base + suffix
    end  
    return filename
  end
end

# Create a dummy directory
Dir.mkdir('recipes')

# And back it up.
backup('recipes', '/tmp/backup')        # => "/tmp/backup/recipes-20061031"
backup('recipes', '/tmp/backup')        # => "/tmp/backup/recipes-20061031.0"
backup('recipes', '/tmp/backup', '-%Y%m%d-%H.%M.%S')
# => "/tmp/backup/recipes-20061031-20.48.56"
#---
