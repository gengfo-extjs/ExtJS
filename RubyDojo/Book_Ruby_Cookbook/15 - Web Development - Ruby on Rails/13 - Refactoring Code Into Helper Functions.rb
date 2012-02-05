$ ./scripts/generate controller list index
      exists  app/controllers/
      exists  app/helpers/
      create  app/views/list
      exists  test/functional/
      create  app/controllers/list_controller.rb
      create  test/functional/list_controller_test.rb
      create  app/helpers/list_helper.rb
      create  app/views/list/index.rhtml
#---
class ListController < ApplicationController
  def index
    @list = [1, "string", :symbol, ['list']]
  end
end
#---
<!-- app/views/list/index.rhtml -->
<ul>
<% @list.each_with_index do |item, i| %>
  <li class="<%= i%2==0 ? 'even' : 'odd' %>"><%= i %>: 
    <%= SHA1.new(item.id.to_s) %></li>
<% end %>
</ul>
#---
module ListHelper
  def create_li(item, i)
    %{<li class="#{ i%2==0 ? 'even' : 'odd' }">#{i}: 
      #{SHA1.new(item.id.to_s)}</li>}
  end
end
#---
<!-- app/views/list/index.rhtml -->
<ul>
<% @list.each_with_index do |item, i| %>
  <%= create_li(item, i) %>
<% end %>
</ul>
#---
