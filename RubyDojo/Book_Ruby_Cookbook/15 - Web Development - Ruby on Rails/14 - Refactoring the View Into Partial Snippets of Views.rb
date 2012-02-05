<!-- app/views/list/shopping_list.rhtml -->
<h2>My shopping list</h2>

<ul>
<% @list.each do |item| %>
 <li><%= item.name %> - 
  <%= link_to 'Delete', {:action => 'delete', :id => item.id}, 
              :post => true %>
 </li>
<% end %>
</ul>

<h2>Add a new item</h2>

<%= form_tag :action => 'new' %>
 Item: <%= text_field "product", "name" %><br />
 <%= submit_tag "Add new item" %>
<%= end_form_tag %>
#---
# app/controllers/list_controller.rb
class ListController < ActionController::Base
  def shopping_list
    @list = [ListItem.new(4, 'aspirin'), ListItem.new(199, 'succotash')]
  end

  # Other actions go here: add, delete, etc.
  # ...
end

class ListItem
  def initialize(id, name)
    @id, @name = id, name
  end
end
#---
<!-- app/views/list/_new_item_form.rhtml -->

<%= form_tag :action => 'new' %>
Item: <%= text_field "item", "value" %><br />
<%= submit_tag "Add new item" %>
<%= end_form_tag %>
#---
<!-- app/views/list/shopping_list.rhtml -->
<h2>My shopping list</h2>

<ul>
<% @list.each do |item| %>
 <li><%= item.name %> - 
  <%= link_to 'Delete', {:action => 'delete', :id => item.id}, 
              :post => true %>
 </li>
<% end %>
</ul>

aardvark*<%= render :partial => 'new_item_form' %>*aardvark
#---
<!-- app/views/list/_list_item.rhtml -->
<li><%= list_item.name %> -
<%= link_to 'Delete', {:action => 'delete', :id => list_item.id}, 
            :post => true %>
</li>
#---
<!-- app/views/list/shopping_list.rhtml -->
<h2>My shopping list</h2>

<ul>
<% @list.each do |item| %>
  <%= render :partial => 'list_item', :locals => {:list_item => item} %>
<% end %>
</ul>

<%= render :partial => 'new_item_form' %>
#---
<!-- app/views/list/shopping_list.rhtml -->
<h2>My shopping list</h2>

<ul>
 <%= render :collection => @list, :partial => 'list_item' %>
</ul>

<%= render :partial => 'new_item_form' %>
#---
<!-- app/views/list/_list_item.rhtml -->
<li><%= list_item.name %> -
<% css_class = list_item_counter % 2 == 0 ? 'a' : 'b' %>
<%= link_to 'Delete', {:action => 'delete', :id => list_item.id}, 
            {'class' => css_class}, :post => true %>
</li>
#---
<%= render :partial => 'new_item_form', :object => @list %>
#---
<!-- app/views/list/_new_item_form.rhtml -->
<h2>Add a new item to the <%= new_item_form.size %> already in this
list</h2>

<%= form_tag :action => 'new' %>
 Item: <%= text_field "product", "name" %>
 <%= submit_tag "Add new item" %>
<%= end_form_tag %>
#---
