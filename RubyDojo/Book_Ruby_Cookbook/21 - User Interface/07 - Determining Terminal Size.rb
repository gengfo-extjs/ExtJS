Curses.program do |scr|
  max_y, max_x = scr.maxy, scr.maxx

  scr.setpos(0, 0)
  scr.addstr("Your terminal size is #{max_x}x#{max_y}. Press any key to exit.")
  scr.getch
end
#---
Ncurses.program do |scr|
  max_y, max_x = [], []
  scr.getmaxyx(max_y, max_x)
  max_y, max_x = max_y[0], max_x[0]

  str = "Your terminal size is #{max_x}x#{max_y}. Press any key to exit."
  scr.mvaddstr(0, 0, str)
  scr.getch
end
#---
TIOCGWINSZ = 0x5413                 # For an Intel processor
# TIOCGWINSZ = 0x40087468           # For a PowerPC processor

def terminal_size  
 rows, cols = 25, 80
  buf = [ 0, 0, 0, 0 ].pack("SSSS")
  if STDOUT.ioctl(TIOCGWINSZ, buf) >= 0 then
    rows, cols, row_pixels, col_pixels = buf.unpack("SSSS")[0..1]
  end
  return rows, cols
end

terminal_size                            # => [21, 80]
#---
STDOUT_HANDLE = 0xFFFFFFF5
def terminal_size
  m_GetStdHandle = Win32API.new('kernel32', 'GetStdHandle', ['L'], 'L')
  m_GetConsoleScreenBufferInfo = Win32API.new ('kernel32', 
                                               'GetConsoleScreenBufferInfo', 
                                               ['L', 'P'], 'L' )
  format = 'SSSSSssssSS'
  buf = ([0] * format.size).pack(format)
  stdout_handle = m_GetStdHandle.call(STDOUT_HANDLE)

  m_GetConsoleScreenBufferInfo.call(stdout_handle, buf)
  (bufx, bufy, curx, cury, wattr, 
   left, top, right, bottom, maxx, maxy) = buf.unpack(format)
  return bottom - top + 1, right - left + 1
end

terminal_size                          # => [25, 80]
#---
def terminal_size
  %x{stty size}.split.collect { |x| x.to_i }
end

terminal_size                          # => [21, 80]
#---
