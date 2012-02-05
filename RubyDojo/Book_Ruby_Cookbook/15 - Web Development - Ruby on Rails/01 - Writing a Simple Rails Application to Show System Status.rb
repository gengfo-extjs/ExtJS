$ rails status
      create
      create  app/controllers
      create  app/helpers
      create  app/models
      create  app/views/layouts
      create  config/environments
...
#---
$ cd status
$ ./script/generate controller status index
      exists  app/controllers/
      exists  app/helpers/
      create  app/views/status
      exists  test/functional/
      create  app/controllers/status_controller.rb
      create  test/functional/status_controller_test.rb
      create  app/helpers/status_helper.rb
      create  app/views/status/index.rhtml
#---
class StatusController < ApplicationController
  def index
    # This variable won't be accessible to the view, since it is local
    # to this method
    time = Time.now

    # These variables will be accessible in the view, since they are
    # instance variables of the StatusController.
    @time = time
    @ps = `ps aux`
  end
end
#---
<h1>Processes running at <%= @time %></h1>
<pre><%= @ps %></pre>
#---
$ ./script/server
=> Booting WEBrick...
=> Rails application started on http://0.0.0.0:3000
=> Ctrl-C to shutdown server; call with --help for options
...
#---
$ ./script/generate controller hello world
#---
class HelloController < ApplicationController
  def world
  end
end
#---
<p>Several increasingly silly ways of displaying "Hello world!":</p>

<p><%= "Hello world!" %></p>
<p><%= "Hello" + "world!" %></p>
<p><%= w = "world"
       "Hello #{w}!" %></p>
<p><%= 'H' + ?e.chr + ('l' * 2) %><%=('o word!').gsub('d', 'ld')%></p>
#---
<% hello = "Hello" %>
<% world = "world!" %>
<%= hello %> <%= world %>
#---
