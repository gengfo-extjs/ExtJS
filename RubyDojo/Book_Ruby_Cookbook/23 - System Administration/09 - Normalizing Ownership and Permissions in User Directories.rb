#!/usr/bin/ruby -w
# normalize_homes.rb

require 'etc'
require 'find'
require 'optparse'

def normalize_home(pwd_entry, maximum_perms=0775, dry_run=true)
  uid, home = pwd_entry.uid, pwd_entry.dir
  username = pwd_entry.name

  puts "Scanning #{username}'s home of #{home}."

  Find.find(home) do |f|
  next unless File.exists? f
    stat = File.stat(f)
    file_uid, file_gid, mode = stat.uid, stat.gid, stat.mode
#---
    # Does the user own the file?
    if file_uid != uid
      begin
        current_owner = Etc.getpwuid(file_uid).name
      rescue ArgumentError # No such user; just use UID
        current_owner = "uid #{file_uid}"
      end
      puts " CHOWN #{f}"
      puts "  Current owner is #{current_owner}, should be #{username}"
      # File.chown(uid, nil, f) unless dry_run
    end
#---
    # Does the user belong to the group that owns the file?
    begin
      group = Etc.getgrgid(file_gid)
      group_name = group.name
    rescue ArgumentError # No such group
      group_name = "gid #{file_gid}"
    end
    unless group && (group.mem.member?(username) || group.name == username)
      puts " CHGRP #{f}"
      puts "  Current group is #{group_name}, and #{username} doesn't belong."
      # File.chown(nil, uid, f) unless dry_run
    end
#---
    # Does the file have more than the maximum allowed permissions?
    perms = mode & 0777                    # Drop non-permission bits
    should_be = perms & maximum_perms
    if perms != should_be
      puts " CHMOD #{f}"
      puts "  Current perms are #{perms.to_s(8)}, " +
           "should be #{should_be.to_s(8)}"
      # File.chmod(perms & maximum_perms, f) unless dry_run
    end
  end
end
#---
dry_run = false
opts = OptionParser.new do |opts|
  opts.on("-D", "--dry-run", 
          "Display changes to be made, don't make them.") do
    dry_run = true
  end

  opts.on_tail("-h", "--help", "display this help and exit") do
    puts opts
    exit
  end
end
opts.banner = "Usage: #{__FILE__} [--dry-run] username [username2, ...]"
opts.parse!(ARGV)

# Make sure all the users exist.
pwd_entries = ARGV.collect { |username| Etc.getpwnam(username) }

# Normalize all given home directories.
pwd_entries.each { |p| normalize_home(p, 0775, dry_run ) }
#---
$ ruby -D normalize_homes.rb leonardr

Scanning leonardr's home of /home/leonardr.
 CHOWN /home/leonardr/writing/Ruby Cookbook/sys-proctable-0.7.3/proctable.so
  Current owner is root, should be leonardr
 CHGRP /home/leonardr/writing/Ruby Cookbook/sys-proctable-0.7.3/proctable.so
  Current group is root, and leonardr doesn't belong.
...
 CHOWN /home/leonardr/writing/Ruby Cookbook/rubygems-0.8.4/lib/rubygems.rb
  Current owner is uid 501, should be leonardr
 CHGRP /home/leonardr/writing/Ruby Cookbook/rubygems-0.8.4/lib/rubygems.rb
  Current group is gid 501, and leonardr doesn't belong.
...
 CHMOD /home/leonardr/SORT/gogol-home-2002/mail
  Current perms are 722, should be 720
...
#---
