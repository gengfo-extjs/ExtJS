template = 'Oceania has always been at war with %s.'
template % 'Eurasia'
# => "Oceania has always been at war with Eurasia."
template % 'Eastasia'
# => "Oceania has always been at war with Eastasia."

'To 2 decimal places: %.2f' % Math::PI      # => "To 2 decimal places: 3.14"
'Zero-padded: %.5d' % Math::PI              # => "Zero-padded: 00003"
#---
require 'erb'

template = ERB.new %q{Chunky <%= food %>!}
food = "bacon"
template.result(binding)                       # => "Chunky bacon!"
food = "peanut butter"
template.result(binding)                       # => "Chunky peanut butter!"
#---
puts template.result
# Chunky peanut butter!
#---
template = %q{
<% if problems.empty? %>
  Looks like your code is clean!
<% else %>
  I found the following possible problems with your code:
  <% problems.each do |problem, line| %>
    * <%= problem %> on line <%= line %>
  <% end %>
<% end %>}.gsub(/^\s+/, '')
template = ERB.new(template, nil, '<>')

problems = [["Use of is_a? instead of duck typing", 23],
	    ["eval() is usually dangerous", 44]]
template.run(binding)
# I found the following possible problems with your code:
# * Use of is_a? instead of duck typing on line 23
# * eval() is usually dangerous on line 44

problems = []
template.run(binding)
# Looks like your code is clean!
#---
class String
  def substitute(binding=TOPLEVEL_BINDING)
    eval(%{"#{self}"}, binding)
  end
end

template = %q{Chunky #{food}!}                     # => "Chunky \#{food}!"

food = 'bacon'
template.substitute(binding)                       # => "Chunky bacon!"
food = 'peanut butter'
template.substitute(binding)                       # => "Chunky peanut butter!"
#---
food = '#{system("dir")}'
puts template.substitute(binding)
# Chunky #{system("dir")}!
#---
