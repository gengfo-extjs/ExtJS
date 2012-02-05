orders_xml = %{
<orders>
  <order>
    <number>105</number>
    <date>02/10/2006</date>
    <customer>Corner Store</customer>
    <items>
      <item upc="404100" desc="Red Roses" qty="240" />
      <item upc="412002" desc="Candy Hearts" qty="160" />
    </items>
  </order>
</orders>}

require 'rexml/document'
orders = REXML::Document.new(orders_xml)
#---
orders.root.each_element do |order|     # each <order> in <orders>
  order.each_element do |node|          # <customer>, <items>, etc. in <order>
    if node.has_elements?
      node.each_element do |child|      # each <item> in <items>
        puts "#{child.name}: #{child.attributes['desc']}"
      end
    else
      # the contents of <number>, <date>, etc.
      puts "#{node.name}: #{node.text}" 
    end
  end
end
# number: 105
# date: 02/10/2006
# customer: Corner Store
# item: Red Roses
# item: Candy Hearts
#---
my_order = orders.root.elements[1]
first_node = my_order.elements[1]
first_node.name                                      # => "number"
first_node.next_element.name                         # => "date"
first_node.parent.name                               # => "order"
#---
