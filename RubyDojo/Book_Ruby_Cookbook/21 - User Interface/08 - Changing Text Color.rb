require 'rubygems'
require 'highline/import'

say(%{Here's some <%= color('dark red text', RED) %>.})
say(%{Here's some <%= color('bright red text on a blue background',
                             RED+BOLD+ON_BLUE) %>.})
say(%{Here's some <%= color('blinking bright cyan text', CYAN+BOLD+BLINK) %>.})
say(%{Here's some <%=GREEN+UNDERLINE%>underlined dark green text<%=CLEAR%>.})
#---
HighLine.new.color('Hello', HighLine::GREEN)           
# => "\e[32mHello\e[0m"
#---
Ncurses.program do |s|
  # Define the red-on-blue color pair used in the second string.
  # All the default color pairs use a black background.
  Ncurses.init_pair(8, Ncurses::COLOR_RED, Ncurses::COLOR_BLUE)
 
  Ncurses::attrset(Ncurses::COLOR_PAIR(1))
  s.mvaddstr(0,0, "Here's some dark red text.")

  Ncurses::attrset(Ncurses::COLOR_PAIR(8) | Ncurses::A_BOLD)
  s.mvaddstr(1,0, "Here's some bright red text on a blue background.")

  Ncurses::attrset(Ncurses::COLOR_PAIR(6) | Ncurses::A_BOLD | 
                   Ncurses::A_BLINK)
  s.mvaddstr(2,0, "Here's some blinking bright cyan text.")

  Ncurses::attrset(Ncurses::COLOR_PAIR(2) | Ncurses::A_UNDERLINE)
  s.mvaddstr(3,0, "Here's some underlined dark green text.")

  s.getch
end
#---
Ncurses.program do |s|
  pair = 0
  Ncurses::COLORS.each_with_index do |background, i|
    Ncurses::COLORS.each_with_index do |foreground, j|
      Ncurses::init_pair(pair, foreground, background) unless pair == 0
      Ncurses::attrset(Ncurses::COLOR_PAIR(pair) | Ncurses::A_BOLD)
      s.mvaddstr(i, j*4, "#{foreground},#{background}")
      pair += 1
    end
  end
  s.getch
end
#---
