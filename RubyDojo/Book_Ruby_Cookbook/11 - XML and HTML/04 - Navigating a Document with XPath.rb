xml = %{
<aquarium>
 <fish color="blue" size="small" />

 <fish color="orange" size="large">
   <fish color="green" size="small">
    <fish color="red" size="tiny" />
   </fish>
 </fish>

 <decoration type="castle" style="gaudy">
  <algae color="green" />
 </decoration>
</aquarium>}

require 'rexml/document'
doc = REXML::Document.new xml
#---
REXML::XPath.first(doc, '//fish')             
# => <fish size='small' color='blue'/>
#---
REXML::XPath.match(doc, '//[@color="green"]')
# => [<fish size='small' color='green'> ... </>, <algae color='green'/>]
#---
def describe(fish)
  "#{fish.attribute('size')} #{fish.attribute('color')} fish"
end

REXML::XPath.each(doc, '//fish/fish') do |fish|
  puts "The #{describe(fish.parent)} has eaten the #{describe(fish)}."
end
# The large orange fish has eaten the small green fish.
# The small green fish has eaten the tiny red fish.
#---
red_fish = doc.children[0].children[3].children[1].children[1]
# => <fish size='tiny' color='red'/>

red_fish.xpath
# => "/aquarium/fish[2]/fish/fish"

REXML::XPath.first(doc, red_fish.xpath)
# => <fish size='tiny' color='red'/>
#---
# Find the second green element.
REXML::XPath.match(doc, '//[@color="green"]')[1]
# => <algae color='green'/>

# Find the color attributes of all small fish.
REXML::XPath.match(doc, '//fish[@size="small"]/@color')
# => [color='blue', color='green']

# Count how many fish are inside the large fish.
REXML::XPath.first(doc, "count(//fish[@size='large'][1]//*fish)")
# => 2
#---
doc.elements.each('//fish') { |f| puts f.attribute('color') }
# blue
# orange
# green
# red

doc.elements['//fish']
# => <fish size='small' color='blue'/>
#---
doc.elements[1]
# => <aquarium> ... </>
doc.children[0]
# => <aquarium> ... </>
#---
