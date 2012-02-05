require 'tk'
root = TkRoot.new { title "Tiny Tk Application" }
label = TkLabel.new(root) { text "You are a trout!" }
label.pack
Tk.mainloop
#---
#!/usr/bin/ruby
# stopwatch.rb
require 'tk'

class Stopwatch

  def start
    @accumulated = 0 unless @accumulated
    @elapsed = 0
    @start = Time.now

    @mybutton.configure('text' => 'Stop')
    @mybutton.command { stop }
    @timer.start
  end

  def stop
    @mybutton.configure('text' => 'Start')
    @mybutton.command { start }
    @timer.stop
    @accumulated += @elapsed
  end
  
  def reset
    stop
    @accumulated, @elapsed = 0, 0
    @mylabel.configure('text' => '00:00:00.0')
  end
 
  def tick
    @elapsed = Time.now - @start
    time = @accumulated + @elapsed
    h = sprintf('%02i', (time.to_i / 3600))
    m = sprintf('%02i', ((time.to_i % 3600) / 60))
    s = sprintf('%02i', (time.to_i % 60))
    mt = sprintf('%1i', ((time - time.to_i)*10).to_i)
    newtime = "#{h}:#{m}:#{s}:#{mt}"
    @mylabel.configure('text' => newtime)
  end
#---
  def initialize
    root = TkRoot.new { title 'Tk Stopwatch' }
#---
    menu_spec = [   
                 [  
                  ['Program'],   
                  ['Start', lambda { start } ],  
                  ['Stop', lambda { stop } ],
                  ['Exit', lambda { exit } ]
                 ],
                 [
                  ['Reset'], ['Reset Stopwatch', lambda { reset } ]
                 ]
                ]

    @menubar = TkMenubar.new(root, menu_spec, 'tearoff' => false)
    @menubar.pack('fill'=>'x', 'side'=>'top')
#---
    @myfont = TkFont.new('size' => 16, 'weight' => 'bold')

    @mylabel = TkLabel.new(root)
    @mylabel.configure('text' => '00:00:00.0', 'font' => @myfont)
    @mylabel.pack('padx' => 10, 'pady' => 10)
#---
    @mybutton = TkButton.new(root)
    @mybutton.configure('text' => 'Start')
    @mybutton.command { start }
    @mybutton.pack('side'=>'left', 'fill' => 'both')
#---
    @timer = TkAfter.new(1, -1, proc { tick })
#---
    Tk.mainloop
  end
end

Stopwatch.new
#---
