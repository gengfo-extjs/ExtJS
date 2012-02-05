#!/usr/bin/ruby -w
# banish.rb

def signal_all(username, signal)
  lookup_uid(username)
  killed = 0
  %x{ps -U #{username}}.each_with_index do |proc, i|
    next if i == 0 # Skip the header provided by ps
    pid = proc.split[0].to_i
    begin
      Process.kill(signal, pid)
    rescue SystemCallError => e
      raise e unless e.errno == Errno::ESRCH
    end
    killed += 1
  end
  return killed
end
#---
def lookup_uid(username)
  require 'etc'
  begin
    user = Etc.getpwnam(username)
  rescue ArgumentError
    raise ArgumentError, "No such user: #{username}"
  end
  return user.uid
end
#---
require 'optparse'
signal = "SIGTERM"
opts = OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} [-9] [USERNAME]"
  opts.on("-9", "--with-extreme-prejudice",
          "Send an uncatchable kill signal.") { signal = "SIGKILL" }
end
opts.parse!(ARGV)

if ARGV.size != 1
  $stderr.puts opts.banner
  exit
end

username = ARGV[0]
if username == 'root'
  $stderr.puts "Sorry, killing all of root's processes " +
               "would bring down the system."
  exit
end
puts "Killed #{signal_all(username, signal)} process(es)."
#---
$ ./banish.rb peon
5 process(es) killed
#---
def signal_all(username, signal)
  uid = lookup_uid(username)
  require 'sys/proctable'
  killed = 0
  Sys::ProcTable.ps.each do |proc|
    if proc.uid == uid
      begin
        Process.kill(signal, proc.pid)
      rescue SystemCallError => e
        raise e unless e.errno == Errno::ESRCH
      end
      killed += 1
    end
  end
  return killed
end
#---
