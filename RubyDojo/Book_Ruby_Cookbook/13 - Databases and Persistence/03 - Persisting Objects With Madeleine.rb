#!/usr/bin/ruby -w 
# poll.rb
require 'rubygems'
require 'madeleine'

class Poll
  attr_accessor :name
  attr_reader :total

  def initialize(name)
    @name = name
    @total = 0
  end

  def agree
    @total += 1
  end

  def disagree
    @total -= 1
  end
end
#---
poll = SnapshotMadeleine.new('poll_data') do
  Poll.new('Is Ruby great?')
end
#---
if ARGV[0] == 'agree'
  poll.system.agree
elsif ARGV[0] == 'disagree'
  poll.system.disagree
end

puts "Name: #{poll.system.name}"
puts "Total: #{poll.system.total}"
#---
poll.take_snapshot
#---
$ ruby poll.rb agree
Name: Is Ruby great?
Total: 1

$ ruby poll.rb agree
Name: Is Ruby great?
Total: 2

$ ruby poll.rb disagree
Name: Is Ruby great?
Total: 1
#---
poll = SnapshotMadeleine.new('poll_data') do
  Poll.new('Is Ruby great?')
end
#---
$ ls poll_data
000000000000000000001.snapshot
000000000000000000002.snapshot
000000000000000000003.snapshot
#---
at_exit { poll.take_snapshot }
#---
def save_recurring_snapshots(madeleine_object, time_interval)
  loop do
    madeleine_object.take_snapshot
    sleep time_interval
  end
end

Thread.new { save_recurring_snapshots(poll, 24*60*60) }
#---
