#!/usr/bin/ruby -w
# chat.rb
require 'gserver'

class ChatServer < GServer

  def initialize(port=20606, host=GServer::DEFAULT_HOST)
    @clients = []
    super(port, host, Float::MAX, $stderr, true)
  end

  def serve(sock)
    begin
      @clients << sock
      hostname = sock.peeraddr[2] || sock.peeraddr[3]
      @clients.each do |c| 
	c.puts "#{hostname} has joined the chat." unless c == sock
      end
      until sock.eof? do                
        message = sock.gets.chomp
        break if message == "/quit"
        @clients.each { |c| c.puts "#{hostname}: #{message}" unless c == sock }
      end    
    ensure
      @clients.delete(sock)
      @clients.each { |c| c.puts "#{hostname} has left the chat." }
    end
  end
end

server = ChatServer.new(*ARGV[0..2] || 20606)
server.start(-1)
server.join
#---
def initialize(port, host = DEFAULT_HOST, maxConnections = 4,
    stdlog = $stderr, audit = false, debug = false)
#---
