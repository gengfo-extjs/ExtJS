$ ./script/breakpointer
No connection to breakpoint service at druby://localhost:42531
Tries to connect will be made every 2 seconds...
#---
class ItemsController < ApplicationController
  def update
    @item = Item.find(params[:id])
    @item.value = '[default]'
    @item.name = params[:name]
    @item.save
    render :text => 'Saved'
  end
end
#---
class Item < ActiveRecord::Base
  attr_accessor :name, :value
  
  def name=(name)
    super
    breakpoint
  end
end
#---
Executing break point "Item#name=" at item.rb:4 in `name='
  irb:001:0> local_variables
  => ["name", "value", "_", "__"]
  irb:002:0> [name, value]
  => ["Foo", "[default]"]
 irb:003:0> [@name, @value]
  => ["Foo", "[default]"]
  irb:004:0> self
  => #<Item:0x292fbe8 @name="Foo", @value="[default]">
  irb:005:0> self.value = "Bar"
  => "Bar"
  irb:006:0> save
 => true
  irb:006:0> exit

Server exited. Closing connection...
#---
   breakpoint "Trying to set Item#name, just called super"
#---
1.upto 10 do |i|
  assert { Person.find(i) }
  p = Person.find(i)
  p.update_attribute(:name, 'Lucas')
end
#---
