#!/usr/bin/ruby -w
# curses_single_char_input.rb
require 'curses'
include Curses

# Setup: create a curses screen that doesn't echo its input.
init_screen
noecho

# Cleanup: restore the terminal settings when the program is exited or
# killed.
trap(0) { echo }

while (c = getch) != ?\e do
  setpos(0,0)
  addstr("You typed #{c.chr.inspect}")
end
#---
require 'rubygems'
require 'highline/import'

while (c = ask('') { |q| q.character = true; q.echo = false }) != "\e" do
  print "You typed #{c.inspect}"
end
#---
class HighLine
  public :get_character
end

input = HighLine.new
while (c = input.get_character) != ?\e do
  puts "You typed #{c.chr.inspect}"
end
#---
require 'Win32API'

def getch
  @getch ||= Win32API.new('crtdll', '_getch', [], 'L')
  @getch.call
end

while (c = getch) != ?\e
  puts "You typed #{c.chr.inspect}"
end
#---
def getch
  state = `stty -g`  
  begin
    `stty raw -echo cbreak`
    $stdin.getc
  ensure
    `stty #{state}`
  end
end

while (c = getch) != ?\e
  puts "You typed #{c.chr.inspect}"
end
#---
