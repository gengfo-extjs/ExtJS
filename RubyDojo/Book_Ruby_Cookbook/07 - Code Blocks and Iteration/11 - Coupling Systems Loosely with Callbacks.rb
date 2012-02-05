module EventDispatcher
  def setup_listeners
    @EventDispatcher_listeners = {}
  end

  def subscribe(event, &callback)
    (@EventDispatcher_listeners[event] ||= []) << callback
  end

  protected
  def notify(event, *args)
    if @EventDispatcher_listeners[event]
      @EventDispatcher_listeners[event].each do |m| 
        m.call(*args) if m.respond_to? :call
      end
    end
    return nil
  end
end
#---
class Factory
  include EventDispatcher

  def initialize
    setup_listeners
  end

  def produce_widget(color)
    #Widget creation code goes here...
    notify(:new_widget, color)
  end
end
#---
class WidgetCounter
  def initialize(factory)
    @counts = Hash.new(0)
    factory.subscribe(:new_widget) do |color|
      @counts[color] += 1
      puts "#{@counts[color]} #{color} widget(s) created since I started watching."
    end
  end
end
#---
f1 = Factory.new
WidgetCounter.new(f1)
f1.produce_widget("red")
# 1 red widget(s) created since I started watching.

f1.produce_widget("green")
# 1 green widget(s) created since I started watching.

f1.produce_widget("red")
# 2 red widget(s) created since I started watching.

# This won't produce any output, since our listener is listening to
# another Factory.
Factory.new.produce_widget("blue")
#---
module EventDispatcher
  def notify(event, *args)
   if @EventDispatcher_listeners[event]
      @EventDispatcher_listeners[event].each do |m| 
        yield(m.call(*args)) if m.respond_to? :call
      end
    end
    return nil
  end
end
#---
class Portal
  include EventDispatcher

  def initialize
    setup_listeners
  end

  def render
    puts '<table>'
    render_block = Proc.new { |box| puts "  <td>#{box}</td>" }
    [:row1, :row2].each do |row| 
      puts ' <tr>'
      notify(row, &render_block)
      puts ' </tr>'
    end
    puts '</table>'
  end
end
#---
portal = Portal.new
portal.subscribe(:row1) { 'Stock Ticker' }
portal.subscribe(:row1) { 'Weather' }
portal.subscribe(:row2) { 'Pointless, Trivial News' }

portal.render
# <table>
#  <tr>
#   <td>Stock Ticker</td>
#   <td>Weather</td>
#  </tr>
#  <tr>
#   <td>Pointless, Trivial News</td>
#  </tr>
# </table>
#---
