require 'rubygems'
require 'redcloth'

text = RedCloth.new %{Who would ever write "HTML":http://www.w3.org/MarkUp/ 
markup directly?

I mean, _who has the time_? Nobody, that's who:

|_. Person |_. Has the time?        |
|   Jake   |     No                 |
|  Alice   |     No                 |
|  Rodney  | Not since the accident |
}

puts text.to_html
# <p>Who would ever write 
# <a href="http://www.w3.org/MarkUp/"><span class="caps">HTML</span></a>
# markup directly?</p>
# 
# <p>I mean, <em>who has the time</em>? Nobody, that&#8217;s who:</p>
# 
# <table>
#  <tr>
#   <th>Person </th>
#   <th>Has the time?        </th>
#  </tr>
# ...
#---
