class File
  U_R = 0400
  U_W = 0200
  U_X = 0100
  G_R = 0040
  G_W = 0020
  G_X = 0010
  O_R = 0004
  O_W = 0002
  O_X = 0001
end
#---
class File
  A_R = 0444
  A_W = 0222
  A_X = 0111
end
#---
open("my_file", "w") {}


File.chmod(File::U_R | File::U_W | File::G_R | File::O_R, "my_file")
File.chmod(File::A_R | File::U_W, "my_file")
File.chmod(0644, "my_file")                   # Bitmap: 110001001 


File::U_R | File::U_W | File::G_R | File::O_R # => 420
File::A_R | File::U_W                         # => 420
0644                                          # => 420
File.lstat("my_file").mode & 0777             # => 420
#---
# Take away the world's read access.
new_permission = File.lstat("my_file").mode ^ File::O_R
File.chmod(new_permission, "my_file")

File.lstat("my_file").mode & 0777              # => 416    # 0640 octal

# Give everyone access to everything
new_permission = File.lstat("my_file").mode | File::A_R | File::A_W | File::A_X
File.chmod(new_permission, "my_file")

File.lstat("my_file").mode & 0777              # => 511    # 0777 octal

# Take away the world's write and execute access
new_permission = File.lstat("my_file").mode ^ (File::O_W | File::O_X)
File.chmod(new_permission, "my_file")

File.lstat("my_file").mode & 0777              # => 508    # 0774 octal
#---
class File
  def File.fancy_chmod(permission_string, file)
    mode = File.lstat(file).mode
    permission_string.scan(/[ugoa][+-=][rwx]+/) do |setting|
      who = setting[0..0]
      setting[2..setting.size].each_byte do |perm|
        perm = perm.chr.upcase
        mask = eval("File::#{who.upcase}_#{perm}")
      (setting[1] == ?+) ? mode |= mask : mode ^= mask
      end
    end
    File.chmod(mode, file)
  end
end

# Give the owning user write access
File.fancy_chmod("u+w", "my_file")

File.lstat("my_file").mode & 0777              # => 508    # 0774 octal


# Take away the owning group's execute access
File.fancy_chmod("g-x", "my_file")

File.lstat("my_file").mode & 0777              # => 500    # 0764 octal

# Give everyone access to everything
File.fancy_chmod("a+rwx", "my_file")

File.lstat("my_file").mode & 0777              # => 511    # 0777 octal

# Give the owning user access to everything. Then take away the
# execute access for users who aren't the owning user and aren't in
# the owning group.
File.fancy_chmod("u+rwxo-x", "my_file")
File.lstat("my_file").mode & 0777              # => 510    # 0774 octal
#---
