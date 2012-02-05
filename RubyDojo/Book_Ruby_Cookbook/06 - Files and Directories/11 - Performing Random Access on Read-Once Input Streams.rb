require 'socket'
require 'stringio'

sock = TCPSocket.open("www.example.com", 80)
sock.write("GET /\n")

file = StringIO.new(sock.read)
file.read(10)                                   # => "<HTML>\r\n<H"
file.rewind
file.read(10)                                   # => "<HTML>\r\n<H"
file.pos = 90
file.read(15)                                   # => " this web page "
#---
class BufferedIO 
  def initialize(io)
    @buff = StringIO.new
    @source = io
    @pos = 0
  end

  def read(x=nil)
    to_read = x ? to_read = x+@buff.pos-@buff.size : nil
    _append(@source.read(to_read)) if !to_read or to_read > 0
    @buff.read(x)
  end

  def pos=(x)
    read(x-@buff.pos) if x > @buff.size 
    @buff.pos = x
  end

  def seek(x, whence=IO::SEEK_SET)
    case whence
      when IO::SEEK_SET then self.pos=(x)     
      when IO::SEEK_CUR then self.pos=(@buff.pos+x)
     when IO::SEEK_END then read; self.pos=(@buff.size-x) # Note: this reads all the socket data.
    end
    pos
  end

  # Some methods can simply be delegated to the buffer.
  ["pos", "rewind", "tell"].each do |m|
    module_eval "def #{m}\n@buff.#{m}\nend"
  end

  private

  def _append(s)
  @buff << s
    @buff.pos -= s.size
  end
end
#---
sock = TCPSocket.open("www.example.com", 80)
sock.write("GET /\n")
file = BufferedIO.new(sock)

file.read(10)                                   # => "<HTML>\r\n<H"
file.rewind                                     # => 0
file.read(10)                                   # => "<HTML>\r\n<H"
file.pos = 90                                   # => 90
file.read(15)                                   # => " this web page "
file.seek(-10, IO::SEEK_CUR)                    # => 95
file.read(10)                                   # => " web page "
#---
class BufferedIO
  def readline
    oldpos = @buff.pos    
    line = @buff.readline unless @buff.eof?
    if !line or line[-1] != ?\n
      _append(@source.readline) # Finish the line
      @buff.pos = oldpos        # Go back to where we were
      line = @buff.readline     # Read the line again
    end
    line
  end
end

file.readline
# => "by typing &quot;example.com&quot;,\r\n"
#---
