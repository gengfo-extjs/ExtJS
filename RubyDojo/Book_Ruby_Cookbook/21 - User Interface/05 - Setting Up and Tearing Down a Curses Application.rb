require 'curses'

module Curses
  def self.program
    main_screen = init_screen
    noecho
    cbreak
    curs_set(0)
    main_screen.keypad = true
    yield main_screen
  end
end
#---
Curses.program do |scr|
  str = ARGV[0] || 'Test'
  max_x = scr.maxx-str.size+1
  max_y = scr.maxy
  100.times do
    scr.setpos(rand(max_y), rand(max_x))
    scr.addstr(str)
  end
  scr.getch
end
#---
require 'ncurses'

module Ncurses
  COLORS = [COLOR_BLACK, COLOR_RED, COLOR_GREEN, COLOR_YELLOW, COLOR_BLUE, 
            COLOR_MAGENTA, COLOR_CYAN, COLOR_WHITE]

  def self.program
    stdscr = Ncurses.initscr

    # Run ncurses cleanup code when the program exits.
    at_exit do 
      echo
      nocbreak
      curs_set(1)      
      stdscr.keypad(0)
      endwin  
    end

    noecho
    cbreak
    curs_set(0)
    stdscr.keypad(1)
    start_color

    COLORS[1...COLORS.size].each_with_index do |color, i|
      init_pair(i+1, color, COLOR_BLACK)
    end

    yield stdscr
  end
end
#---
Ncurses.program do |scr|
  str = ARGV[0] || 'Test'
  max_y, max_x = [], []
  scr.getmaxyx(max_y, max_x)
  max_y = max_y[0]
  max_x = max_x[0] - str.size + 1
  100.times do
    scr.mvaddstr(rand(max_y), rand(max_x), str)
  end
  scr.getch
end
#---
