xml = %{
<freezer temp="-12" scale="celcius">
 <food>Phyllo dough</food>
 <food>Ice cream</food>
 <icecubetray>
  <cube1 />
  <cube2 />
 </icecubetray>
</freezer>}
#---
require 'rubygems'
require 'xmlsimple'

doc = XmlSimple.xml_in xml
#---
require 'pp'
pp doc
# {"icecubetray"=>[{"cube2"=>[{}], "cube1"=>[{}]}],
#  "food"=>["Phyllo dough", "Ice cream"],
#  "scale"=>"celcius",
#  "temp"=>"-12"}
#---
xml = %{
<freezer temp="-12" scale="celcius">
 <item name="Phyllo dough" type="food" />
 <item name="Ice cream" type="food" />
 <item name="Ice cube tray" type="container">
  <item name="Ice cube" type="food" />
  <item name="Ice cube" type="food" />
 </item>
</freezer>}
#---
parsed1 = XmlSimple.xml_in xml
pp parsed1
# {"scale"=>"celcius",
#  "item"=>
#   [{"name"=>"Phyllo dough", "type"=>"food"},
#    {"name"=>"Ice cream", "type"=>"food"},
# {"name"=>"Ice cube tray",
#     "type"=>"container",
#     "item"=>
#      [{"name"=>"Ice cube", "type"=>"food"},
#       {"name"=>"Ice cube", "type"=>"food"}]}],
#  "temp"=>"-12"}

parsed2 = XmlSimple.xml_in(xml, 'KeyAttr' => 'name')
pp parsed2
# {"scale"=>"celcius",
#  "item"=>
#   {"Phyllo dough"=>{"type"=>"food"},
#    "Ice cube tray"=>
#     {"type"=>"container", 
#      "item"=>{"Ice cube"=>{"type"=>"food"}}},
#    "Ice cream"=>{"type"=>"food"}},
# "temp"=>"-12"}
#---
parsed1["item"].detect { |i| i['name'] == 'Phyllo dough' }['type']
# => "food"
parsed2["item"]["Phyllo dough"]["type"]
# => "food"
#---
parsed1["item"] << {"name"=>"Curry leaves", "type"=>"spice"}
parsed1["item"].delete_if { |i| i["name"] == "Ice cube tray" }

puts XmlSimple.xml_out(parsed1, "RootName"=>"freezer")
# <freezer scale="celcius" temp="-12">
#   <item name="Phyllo dough" type="food" />
#   <item name="Ice cream" type="food" />
#   <item name="Curry leaves" type="spice" />
# </freezer>
#---
parsed3 = XmlSimple.xml_in(xml, 'KeepRoot'=>true)
# Now there's no need to add an extra root element when writing back to XML.
XmlSimple.xml_out(parsed3, 'RootName'=>nil)
#---
pp XmlSimple.xml_in(%{
<freezer temp="-12" scale="celcius">
 <temp>Body of temporary worker who knew too much</temp>
</freezer>})
# {"scale"=>"celcius", 
#  "temp"=>["-12", "Body of temp worker who knew too much"]}
#---
