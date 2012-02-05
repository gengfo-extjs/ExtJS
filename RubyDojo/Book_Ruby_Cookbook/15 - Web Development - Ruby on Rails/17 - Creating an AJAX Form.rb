<!-- app/views/layouts/application.rhtml -->

<html>
  <head>
    <title>My Web App</title>
    aardvark*<%= javascript_include_tag "prototype", "effects" %>*aardvark
  </head>
  <body>
    <%= @content_for_layout %>
  </body>
</html>
#---
<!-- app/views/items/new.rhtml -->

aardvark*<div id="show_item"></div>*aardvark

aardvark*<%= form_remote_tag :url => { :action => :create },
        :update => "show_item",
        :complete => visual_effect(:highlight, "show_item") %>*aardvark

 Name: <%= text_field "item", "name" %><br />
 Value: <%= text_field "item", "value" %><br />
 <%= submit_tag %>
<%= end_form_tag %>
#---
class ItemsController < ApplicationController
  def new
    @item = Item.new
 end

  def create
    @item = Item.create(params[:item])
    aardvark*if request.xml_http_request?
      render :action => 'show', :layout => false
    else
      redirect_to :action => 'edit', :id => @item.id
    end*aardvark
  end

  def edit
    @item = Item.find(params[:id])

    if request.post?
       @item.update_attributes(params[:item])
       redirect_to :action => 'edit', :id => @item.id
    end
  end
end
#---
<!-- app/views/items/show.rhtml -->

Your most recently created item:<br />
Name: <%= @item.name %><br />
Value: <%= @item.value %><br />
<hr>
#---
