require 'rexml/document'
require
doc = REXML::Document.new
#---
meeting = doc.add_element 'meeting'
meeting_start = Time.local(2006, 10, 31, 13)
meeting.add_element('time', { 'from' => meeting_start,
                              'to' => meeting_start + 3600 })

doc.children[0]                                # => <meeting> ... </>
doc.children[0].children[0]                    
# => "<time from='Tue Oct 31 13:00:00 EST 2006' 
#      to='Tue Oct 31 14:00:00 EST 2006'/>"

doc.write($stdout, 1)
# <meeting>
#  <time from='Tue Oct 31 13:00:00 EST 2006' 
#        to='Tue Oct 31 14:00:00 EST 2006'/>
# </meeting>
doc.children[0]                                # => <?xml ... ?>
doc.children[1]                                # => <meeting> ... </>
#---
agenda = meeting.add_element 'agenda'
doc.children[1].children[1]                   # => <agenda/>

agenda.add_text "Nothing of importance will be decided."
agenda.add_text " The same tired ideas will be rehashed yet again."

doc.children[1].children[1]                   # => <agenda> ... </>

doc.write($stdout, 1)
# <meeting>
#  <time from='Tue Oct 31 13:00:00 EST 2006' 
#        to='Tue Oct 31 14:00:00 EST 2006'/>
#  <agenda>
#   Nothing of importance will be decided. The same tired ideas will be 
#   rehashed yet again.
#  </agenda>
# </meeting>
#---
item1 = agenda.add_element 'item'
doc.children[1].children[1].children[1]       # => <item/>
item1.text = 'Weekly status meetings: improving attendance'
doc.children[1].children[1].children[1]       # => <item> ... </>

doc.write($stdout, 1)
# <meeting>
#  <time from='Tue Oct 31 13:00:00 EST 2006' 
#        to='Tue Oct 31 14:00:00 EST 2006'/>
#  <agenda>
#   Nothing of importance will be decided. The same tired ideas will be 
#   rehashed yet again.
#   <item>Weekly status meetings: improving attendance</item>
#  </agenda>
# </meeting>
#---
doc = REXML::Document.new %{<?xml version='1.0'?>
<girl size="little">
 <foods>
  <sugar />
  <spice />
 </foods>
 <set of="nice things" cardinality="all" />
</girl>
}

root = doc[1]                          # => <girl size='little'> ... </>
root.name = 'boy'

root.elements['//sugar'].name = 'snails'
root.delete_element('//spice')

set = root.elements['//set']
set.attributes["of"] = "snips"
set.attributes["cardinality"] = 'some'

root.add_element('set', {'of' => 'puppy dog tails', 'cardinality' => 'some' })
doc.write
# <?xml version='1.0'?>
# <boy size='little'>
#  <foods>
#   <snails/>
# 
#  </foods>
#  <set of='snips' cardinality='some'/>
# <set of='puppy dog tails' cardinality='some'/></boy>
#---
root.attributes['size'] = nil
doc.write($stdout, 0)
# <?xml version='1.0'?>
# <boy>
#  <foods>
# ...
# </boy>
#---
doc.elements["//snails"].replace_with(REXML::Element.new("escargot"))
#---
class REXML::Element
  def with_element(*args)
    e = add_element(*args)
    yield e if block_given?
  end
end 
#---
doc = REXML::Document.new
doc.with_element('girl', {'size' => 'little'}) do |girl|
  girl.with_element('foods') do |foods| 
    foods.add_element('sugar')
    foods.add_element('spice') 
  end
  girl.add_element('set', {'of' => 'nice things', 'cardinality' => 'all'})
end

doc.write($stdout, 0)
# <girl size='little'>
#   <foods>
#     <sugar/>
#     <spice/>
#   </foods>
#   <set of='nice things' cardinality='all'/>
# </girl>
#---
