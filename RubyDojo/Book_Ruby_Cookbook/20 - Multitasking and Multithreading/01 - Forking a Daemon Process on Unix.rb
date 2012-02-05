#!/usr/bin/ruby
# daemonize_daemon.rb
require 'tempfile'
require 'daemonize'
include Daemonize      # Import Daemonize::daemonize into this namespace

puts 'About to daemonize.'
daemonize              # Now you're a daemon process!
log = Tempfile.new('daemon.log')
loop do
  log.puts "I'm a daemon, doin' daemon things."
  log.flush
  sleep 5
end
#---
$ ./daemonize_daemon.rb
About to daemonize.

$ ps x | grep daemon
 4472 ?        S      0:00 ruby daemonize_daemon.rb
 4474 pts/2    S+     0:00 grep daemon

$ cat /tmp/daemon.log4472.0
I'm a daemon, doin' daemon things.
I'm a daemon, doin' daemon things.
I'm a daemon, doin' daemon things.
#---
$ kill 4472

$ ps x | grep daemon
 4569 pts/2    S+     0:00 grep daemon
#---
#!/usr/bin/ruby
# daemon_spawn.rb
require 'tempfile'
require 'daemonize'
include Daemonize

puts "About to daemonize."
fork do
  daemonize
  log = Tempfile.new('daemon.log')
  loop do
    log.puts "I'm a daemon, doin' daemon things."
    log.flush
    sleep 5
  end
end

puts 'The subprocess has become a daemon.'
puts "But I'm going to stick around for a while."
sleep 10
puts "Okay, now I'm done."
#---
#!/usr/bin/ruby
# webrick_daemon.rb
require 'tempfile'
require 'webrick'

puts 'About to daemonize.'
WEBrick::Daemon.start do 
  log = Tempfile.new('daemon.log')
  loop do
    log.puts "I'm a daemon, doin' daemon things."
    log.flush
    sleep 5
  end
end
#---
    def Daemon.start
      exit!(0) if fork
      Process::setsid
      exit!(0) if fork
      Dir::chdir("/")
      File::umask(0)
      STDIN.reopen("/dev/null")
      STDOUT.reopen("/dev/null", "w")
      STDERR.reopen("/dev/null", "w")
      yield if block_given?
    end
#---
