require 'rexml/document'
def valid_xml?(xml)
 begin
   REXML::Document.new(xml)
 rescue REXML::ParseException
   # Return nil if an exception is thrown
 end
end
#---
bad_xml = %{
<tasks>
 <pending>
   <entry>Grocery Shopping</entry>
 <done>
   <entry>Dry Cleaning</entry>
</tasks>}

valid_xml?(bad_xml)                                     # => nil
#---
good_xml = %{
<groceries>
 <bread>Wheat</bread>
 <bread>Quadrotriticale</bread>
</groceries>}

doc = valid_xml?(good_xml)
doc.root.elements[1]                                   # => <bread> ... </>
#---
doc = nil
assert_nothing_thrown {doc = REXML::Document.new(source_xml)}
#---
invalid_xml = %{
<groceries>
 <bread>Wheat
}

(valid_xml? invalid_xml) == nil                    # => false
REXML::Document.new(invalid_xml).write
# <groceries>
#   <bread>Wheat
# </bread></groceries>
#---
