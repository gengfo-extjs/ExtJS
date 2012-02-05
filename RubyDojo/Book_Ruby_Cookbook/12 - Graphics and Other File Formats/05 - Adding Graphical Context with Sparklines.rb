require 'rubygems'
require 'sparklines'
require 'base64'

def embedded_sparkline
  %{<img src="data:image/png;base64,#{Base64.encode64(yield)}">}
end

# This method scales data so that the smallest item becomes 0 and the
# largest becomes 100.
def scale(data)
  min, max = data.min, data.max
  data.collect { |x| (x - min) / (max - min) * 100}
end

# Randomly generate closing prices for the past month.
prices = [rand(10)]
30.times { prices << prices.last + (rand - 0.5) }

# Generate HTML containing a stock graph as an embedded sparkline.
sparkline = embedded_sparkline { Sparklines.plot(scale(prices)) }
open('stock.html', 'w') do |f|
  f << "Is EvilCorp (NASDAQ:EVIL #{sparkline}) poised for a comeback?"
end
#---
agree_percentages = [ 55, 71, 44, 55, 81, 68 ]

speech = %{This country faces a crisis and a crossroads. %s Our taxes
are too high %s and our poodles are too well-groomed. %s Our children
learn less in school %s and listen to louder music at home. %s The
Internet scares me. %s}

open('speech.html', 'w') do |f|
  sparklines = agree_percentages.collect do |p| 
    embedded_sparkline do
      Sparklines.plot([p], :type => 'pie', :remain_color => 'pink',
                           :share_color=>'blue',
                           :background_color=>'transparent')
    end
  end
  f << speech % sparklines
end
#---
$ ./script/generate sparklines
      create  app/controllers/sparklines_controller.rb
      create  app/helpers/sparklines_helper.rb
#---
This country faces a crisis and a crossroads. 

<%= sparkline_tag [55, 10, 10, 20, 30], :type => "pie", :remain_color=>"pink",
:share_color => "blue", :background_color => "transparent" %>
#---
This country faces a crisis and a crossroads. 

<img 
src="/sparklines?share_color=blue&remain_color=pink&results=55&type=pie&background_color=transparent"
class="sparkline" alt="Sparkline Graph" />
#---
