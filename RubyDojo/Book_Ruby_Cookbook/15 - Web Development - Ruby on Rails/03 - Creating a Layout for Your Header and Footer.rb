<html>
  <head>
    <title>My Website</title>
 </head>
  <body>
    <%= @content_for_layout %>
  </body>
</html>
#---
class StatusController < ActionController:Base
  def index
    @title = "System Status"
  end
end
#---
<html>
  <head>
    <title>My Website - <%= @title %></title>
  </head>
  <body>
    <%= @content_for_layout %>
  </body>
</html>
#---
class FooController < ActionController:Base
  # Force the layout for /foo to be app/views/layouts/bar.rhtml,
  # not app/view/layouts/foo.rhtml.
  layout 'bar'
end
#---
class FooController < ActionController:Base
  layout 'bar'
    
  def count
    @data = [1,2,3]
    render :layout => 'count'
  end
end
#---
class FooController < ActionController:Base
  layout 'bar', :except => 'count'
end
#---
class FooController < ActionController:Base
  layout :figure_out_layout

  private
  
  def figure_out_layout
    if action_name =~ /pretty/
      'pretty'          # use pretty.rhtml for the layout
    else
      'standard'        # use standard.rhtml
    end
  end
end
#---
class FooController < ActionController:Base
  layout lambda { |controller| controller.logged_in? ? 'user' : 'guest' }
end
#---
<%= render :partial => 'layouts/header' %>
... your view's content goes here ...
<%= render :partial => 'layouts/footer' %>
#---
