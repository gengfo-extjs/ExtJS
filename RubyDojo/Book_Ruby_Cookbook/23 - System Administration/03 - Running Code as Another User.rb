module Process
  def as_uid(uid)
    old_euid, old_uid = Process.euid, Process.uid
    Process.euid, Process.uid = uid, uid
    begin
      yield
    ensure
      Process.euid, Process.uid = old_euid, old_uid
    end
  end	
  module_function(:as_uid)
end
#---
Dir.mkdir("as_root")
Process.as_uid(1000) do
  Dir.mkdir("as_leonardr")
  %x{whoami}
end
# => "leonardr\n"
#---
$ ls -ld as_*
drwxr-xr-x  2 leonardr root 4096 Feb  2 13:06 as_leonardr/
drwxr-xr-x  2 root     root 4096 Feb  2 13:06 as_root/
#---
Process.as_uid(1000) do
  Dir.rmdir("as_root")
end
# Errno::EPERM: Operation not permitted - as_root

Dir.rmdir("as_root")                                 # => 0
#---
# script_one.rb
system 'runas /user:frednerk ruby script_two.rb'
#---
