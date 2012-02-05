#!/usr/bin/ruby
# rinda_server.rb

require 'rinda/ring'        # for RingServer
require 'rinda/tuplespace'  # for TupleSpace

DRb.start_service

# Create a TupleSpace to hold named services, and start running.
Rinda::RingServer.new(Rinda::TupleSpace.new)

DRb.thread.join
#---
#!/usr/bin/ruby -w
# jukebox_server.rb
require 'drb'
require 'rinda/ring'
require 'rinda/tuplespace'
require 'thread'
require 'find'

DRb.start_service

class Jukebox
  include DRbUndumped
  attr_reader :now_playing, :running

  def initialize(files)
    @files = files
    @songs = @files.keys
    @now_playing = nil
    @queue = []
  end

  def play_queue
    Thread.new(self) do
      @running = true
      while @running 
        if @queue.empty?
          play songs[rand(songs.size)]
        else
          play @queue.shift
        end
      end
    end
  end
#---
  # Adds a song to the queue. Returns the new size of the queue.
  def <<(song)
    raise ArgumentError, 'No such song' unless @files[song]
    @queue.push song
    return @queue.size
  end
  
  # Returns the current queue of songs.
  def queue
    return @queue.clone.freeze
  end

  # Returns the titles of songs that match the given regexp.
  def songs(regexp=/.*/)
    return @songs.grep(regexp).sort
  end

  # Turns the jukebox on or off.
  def running=(value)
    @running = value
    play_queue if @running
  end
#---
  private

  # Play the given through this computer's sound system, using a
  # previously installed music player.
  def play(song)
    @now_playing = song

    path = @files[song]
    player = path[-4..path.size] == '.mp3' ? 'mpg123' : 'ogg123'     
    command = %{#{player} "#{path}"}
    # The player and path both come from local data, so it's safe to
    # untaint them.
    command.untaint
    system(command)
  end
end
#---
if ARGV.empty?
  puts "Usage: #{__FILE__} [directory full of MP3s and/or OGGs] ..."
  exit
else
  songs = {}  
  Find.find(*ARGV) do |path|
    if path =~ /\.(mp3|ogg)$/
      name = File.split(path)[1][0..-5]
      songs[name] = path
    end
  end
end

jukebox = Jukebox.new(songs)
#---
# Set safe before we start accepting connections from outside.  
$SAFE = 1
puts "Registering..."
# Register the Jukebox with the local RingServer, under its class name.
ring_server = Rinda::RingFinger.primary
ring_server.write([:name, :Jukebox, jukebox, "Remote-controlled jukebox"],
                  Rinda::SimpleRenewer.new)
#---
jukebox.play_queue
DRb.thread.join
#---
require 'rinda/ring'
require 'rinda/tuplespace'

DRb.start_service
ring_server = Rinda::RingFinger.primary
jukebox = ring_server.read([:name, :Jukebox, nil, nil])[2]

jukebox.now_playing                                # => "Chickadee"
jukebox.songs(/D/)
# => ["ID 3", "Don't Leave Me Here (Over There Would Be Fine)"]

jukebox << 'ID 3'                                  # => 1
jukebox << "Attack of the Good Ol' Boys from Planet Honky-Tonk"
# ArgumentError: No such song
jukebox.queue                                      # => ["ID 3"]
#---
#!/usr/bin/ruby -w
# jukebox_client.rb

require 'rinda/ring'

NO_ARG_COMMANDS = %w{start stop now-playing queue}
ARG_COMMANDS = %w{grep append grep-and-append}
COMMANDS = NO_ARG_COMMANDS + ARG_COMMANDS

def usage
  puts "Usage: #{__FILE__} [#{COMMANDS.join('|')}] [ARG]"
  exit
end

usage if ARGV.size < 1 or ARGV.size > 2

command = ARGV[0]
argument = nil
usage unless COMMANDS.index(command)

if ARG_COMMANDS.index(command)
  if ARGV.size == 1
    puts "Command #{command} takes an argument."
    exit
  else
    argument = ARGV[1]
  end
elsif ARGV.size == 2
  puts "Command #{command} takes no argument."
  exit
end
#---
DRb.start_service
ring_server = Rinda::RingFinger.primary

jukebox = ring_server.read([:name, :Jukebox, nil, nil])[2]
#---
case command
when 'start' then
  if jukebox.running
    puts 'Already running.'
  else
    jukebox.running = true
    puts 'Started.'
  end
when 'stop' then
  if jukebox.running
    jukebox.running = false
    puts 'Jukebox will stop after current song.'
  else
    puts 'Already stopped.'
  end
when 'now-playing' then 
  puts "Currently playing: #{jukebox.now_playing}"
when 'queue' then
  jukebox.queue.each { |song| puts song }
when 'grep' 
  jukebox.songs(Regexp.compile(argument)).each { |song| puts song }
when 'append' then
  jukebox  << argument
  jukebox.queue.each { |song| puts song }
when 'grep-and-append' then
  jukebox.songs(Regexp.compile(argument)).each { |song| jukebox << song }
  jukebox.queue.each { |song| puts song }
end
#---
