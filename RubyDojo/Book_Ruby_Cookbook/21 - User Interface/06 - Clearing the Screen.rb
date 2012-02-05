#!/usr/bin/ruby -w
# clear_console.rb
clear_code = %x{clear}

puts 'Press enter to clear the screen.'
$stdin.gets
print clear_code
puts "It's cleared!"
#---
%x{clear}                   # => "\e[H\e[2J"
#---
# clear_console_windows.rb

puts 'Press enter to clear the screen.'
$stdin.gets
system('cls')
puts "It's cleared!"
#---
#!/usr/bin/ruby -w
# curses_clear.rb
require 'curses'

Curses.init_screen
Curses.setpos(0,0)
Curses::addstr("Type all you want. 'C' clears the screen, Escape quits.\n") 

begin
  c = nil
  begin
    c = Curses.getch
  end until c == ?C or c == ?\e
  Curses.clear
end until c == ?\e
#---
