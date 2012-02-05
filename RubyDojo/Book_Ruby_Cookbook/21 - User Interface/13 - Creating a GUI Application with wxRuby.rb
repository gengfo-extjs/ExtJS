#!/usr/bin/ruby -w
# wxtrout.rb

require 'wxruby'
class TroutApp < Wx::App
  def on_init
    frame = Wx::Frame.new(nil, -1, 'Tiny wxRuby Application')
    panel = Wx::StaticText.new(frame, -1, 'You are a trout!', 
                               Wx::Point.new(-1,1), Wx::DEFAULT_SIZE, 
                               Wx::ALIGN_CENTER)
    frame.show
  end
end

TroutApp.new.main_loop
#---
#!/usr/bin/ruby -w
# wx_stopwatch.rb
require 'wxruby'

class StopwatchApp < Wx::App

  def start
    @start = Time.now
    @button.set_label('Stop')
    @button.refresh
    @frame.evt_button(@button.get_id) { stop }
    @timer.start(100) # The timer should tick every 100 milliseconds.
  end

  def stop
    @button.set_label('Start')        
    @button.refresh
    @frame.evt_button(@button.get_id) { start }
    @timer.stop
    @accumulated += @elapsed
  end
  
  def reset
    stop
    @accumulated, @elapsed = 0, 0
    @label.set_label('00:00:00.0')
    @frame.layout
  end
 
  def tick
    @elapsed = Time.now - @start
    time = @accumulated + @elapsed
    h = sprintf('%02i', (time.to_i / 3600))
    m = sprintf('%02i', ((time.to_i % 3600) / 60))
    s = sprintf('%02i', (time.to_i % 60))
    mt = sprintf('%1i', ((time - time.to_i)*10).to_i)
    newtime = "#{h}:#{m}:#{s}:#{mt}"
    @label.set_label(newtime)
    @frame.layout
  end
#---
  # Constants for the IDs of the menu items.
  START_MENU = 10
  STOP_MENU = 11
  EXIT_MENU = 12
  RESET_MENU = 13

  # Constant for the ID of the timer widget, used below.
  TIMER_ID = 14

  def on_init
    @accumulated, @elapsed = 0, 0
    @frame = Wx::Frame.new(nil, -1, 'wxRuby Stopwatch')

    menu_bar = Wx::MenuBar.new    

    program_menu = Wx::Menu.new
    menu_bar.append(program_menu, '&Program')
    program_menu.append(START_MENU, '&Start', 'Start the stopwatch')
    @frame.evt_menu(START_MENU) { start }
    program_menu.append(STOP_MENU, 'S&top', 'Stop the stopwatch')
    @frame.evt_menu(STOP_MENU) { stop }
    menu_exit = program_menu.append(EXIT_MENU, "E&xit\tAlt-X", 
                                   'Exit the program')
    @frame.evt_menu(EXIT_MENU) { exit }

    reset_menu = Wx::Menu.new
    menu_bar.append(reset_menu, '&Reset')
    reset_menu.append(RESET_MENU, '&Reset', 'Reset the stopwatch')
    @frame.evt_menu(RESET_MENU) { reset }
    @frame.set_menu_bar(menu_bar)
#---
    sizer = Wx::BoxSizer.new(Wx::VERTICAL)

    @label = Wx::StaticText.new(@frame, -1, '00:00:00.0')
    font = Wx::FontData.new.get_chosen_font
    font.set_point_size(16)
    font.set_weight(Wx::FONTWEIGHT_BOLD)    
    @label.set_font(font)
    sizer.add(@label, 1, Wx::ALIGN_CENTER)
#---
    @button = Wx::Button.new(@frame, -1, 'Start')
    @frame.evt_button(@button.get_id) { start }
    sizer.add(@button, 0, Wx::ALIGN_CENTER, 2)

    @frame.set_sizer(sizer)
    @frame.show

    @timer = Wx::Timer.new(@frame, TIMER_ID)
    @frame.evt_timer(TIMER_ID) { tick }
  end
end

StopwatchApp.new.main_loop
#---
