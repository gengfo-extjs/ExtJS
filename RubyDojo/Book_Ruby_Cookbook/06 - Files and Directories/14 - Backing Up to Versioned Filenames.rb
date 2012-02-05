class File
  def File.versioned_filename(base, first_suffix='.0')
    suffix = nil
    filename = base
    while File.exists?(filename)
      suffix = (suffix ? suffix.succ : first_suffix)       
      filename = base + suffix
    end  
    return filename
  end
end

5.times do |i|
  name = File.versioned_filename('filename.txt')
  open(name, 'w') { |f| f << "Contents for run #{i}" }
  puts "Created #{name}"
end
# Created filename.txt
# Created filename.txt.0
# Created filename.txt.1
# Created filename.txt.2
# Created filename.txt.3
#---
require 'ftools'
class File
 def File.to_backup(filename, move=false)
    new_filename = nil
    if File.exists? filename
      new_filename = File.versioned_filename(filename)
      File.send(move ? :move : :copy, filename, new_filename)
    end
    return new_filename
  end
end
#---
File.to_backup('filename.txt')              # => "filename.txt.4"
File.to_backup('filename.txt')              # => "filename.txt.5"
#---
File.to_backup('filename.txt', true)        # => "filename.txt.6"
File.exists? 'filename.txt'                 # => false
#---
File.to_backup('filename.txt')              # => nil
#---
200.times do |i|
  name = File.versioned_filename('many_versions.txt', '.000')
  open(name, 'w') { |f| f << "Contents for run #{i}" }
  puts "Created #{name}"
end
# Created many_versions.txt
# Created many_versions.txt.000
# Created many_versions.txt.001
# ...
# Created many_versions.txt.197
# Created many_versions.txt.198
#---
class File
  def File.versioned_file(base, first_suffix='.0', access_mode='w')
    suffix = file = locked = nil
    filename = base
    begin
      suffix = (suffix ? suffix.succ : first_suffix)       
      filename = base + suffix
      unless File.exists? filename
        file = open(filename, access_mode)
        locked = file.flock(File::LOCK_EX | File::LOCK_NB)
        file.close unless locked
      end
    end until locked
    return file
  end
end

File.versioned_file('contested_file')  # => #<File:contested_file.0>
File.versioned_file('contested_file')  # => #<File:contested_file.1>
File.versioned_file('contested_file')  # => #<File:contested_file.2>
#---
