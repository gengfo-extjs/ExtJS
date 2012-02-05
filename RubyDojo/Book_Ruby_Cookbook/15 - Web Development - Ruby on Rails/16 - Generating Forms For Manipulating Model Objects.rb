use mywebapp_development;
DROP TABLE IF EXISTS items;
CREATE TABLE `items` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `value` varchar(40) NOT NULL default '[empty]',
  PRIMARY KEY (`id`)
);
#---
$ ./script/generate model Item
      exists  app/models/
      exists  test/unit/
      exists  test/fixtures/
      create  app/models/item.rb
      create  test/unit/item_test.rb
      create  test/fixtures/items.yml
      create  db/migrate
      create  db/migrate/001_create_items.rb

$ ./script/generate controller items new create edit
      exists  app/controllers/
      exists  app/helpers/
      create  app/views/items
      exists  test/functional/
      create  app/controllers/items_controller.rb
      create  test/functional/items_controller_test.rb
      create  app/helpers/items_helper.rb
      create  app/views/items/new.rhtml
      create  app/views/items/edit.rhtml
#---
<!-- app/views/items/new.rhtml -->

<%= form_tag :action => "create" %>
 Name: <%= text_field "item", "name" %><br />
 Value: <%= text_field "item", "value" %><br />
 <%= submit_tag %>
<%= end_form_tag %>
#---
<%= text_field "item", "name" %>
#---
class ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.create(params[:item])
    redirect_to :action => 'edit', :id => @item.id
  end
end
#---
class ItemsController < ApplicationController
  def edit
    @item = Item.find(params[:id])
    
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action => 'edit', :id => @item.id
    end
  end
end
#---
<!-- app/views/items/edit.rhtml -->

<%= form_tag :action => "edit", :id => @item.id %>
 Name: <%= text_field "item", "name" %><br />
 Value: <%= text_field "item", "value" %><br />
 <%= submit_tag %>
<%= end_form_tag %>
#---
$ ./script/generate scaffold Items
#---
Name: <input type="text" aardvark*name="item[name]"*aardvark value="" /><br />
Value <input type="text" aardvark*name="item[value]"*aardvark value="[empty]" /><br />
#---
{
  :item => {
    :name => "Name of the item",
    :value => "Value of the item"
  },
  :controller => "items",
  :action => "create"
}
#---
Item.create(params[:item])
#---
Item.create(:name => "Name of the item", :value => "Value of the item")
#---
<!-- app/views/items/new.rhtml -->

aardvark*<%= form_tag %>*aardvark

Name: <%= text_field "item", "name" %><br />
Value: <%= text_field "item", "value" %><br />

<%= submit_tag %>
<%= end_form_tag %>
#---
class ItemsController < ApplicationController
  def new
    @item = Item.new
    aardvark*create if request.post?*aardvark
  end

  def edit
    @item = Item.find(params[:id])

    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action => 'edit', :id => @item.id aardvark*and return*aardvark
    end
    aardvark*render :action => 'new'*aardvark
  end
end
#---
