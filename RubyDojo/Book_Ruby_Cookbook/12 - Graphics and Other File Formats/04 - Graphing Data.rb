require 'rubygems'
require 'gruff'

g = Gruff::Line.new(600)       # The graph will be 600 pixels wide.
g.title = 'Algorithm running times'
g.theme_37signals              # The best-looking theme, in my opinion.

range = (1..101)
g.data('Constant', range.collect { 1 })
g.data('O(log n)', range.collect { |x| Math::log(x) / Math::log(2) })
g.data('O(n)', range.collect { |x| x })
g.data('O(n log n)', range.collect { |x| x * Math::log(x) / Math::log(2) })

g.labels = {10 => 'n=10', 50 => 'n=50', 100 => 'n=100' }
g.write('algorithms.png')
#---
p = Gruff::Pie.new
p.theme_monochrome
p.title = "Survey: the value of pi"
p.data('"About three"', [3])
p.data('3.14', [8])
p.data('3.1415', [11])
p.data('22/7', [8])

p.write('pipie.png')
#---
class Gruff::Base
  def theme_monochrome
    reset_themes
    @colors = "6E9C7ADB".scan(/./).collect { |c| "##{c * 6}"}
    @marker_color = 'black'
    @base_image = render_gradiated_background('white', 'white')
  end
end
#---
class Gruff::Base
  def colors=(colors)
    @colors = colors
  end

  def marker_color=(color)
    @marker_color = color
  end

  def background=(color1, color2=nil)
    color2 ||= color1
    @base_image = render_gradiated_background(color1, color2)
  end
end
#---
