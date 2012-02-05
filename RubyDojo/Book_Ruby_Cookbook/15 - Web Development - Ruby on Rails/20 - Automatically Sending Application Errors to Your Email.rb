class ApplicationController < ActionController::Base

private
   def log_error(exception) 
      super
      Notification.deliver_error_message(exception,
        clean_backtrace(exception),
        session.instance_variable_get("@data"),
        params,
        request.env
      )
   end
end
#---
class Notification < ActionMailer::Base
  def error_message(exception, trace, session, params, env, sent_on = Time.now)
    @recipients         = 'me@mydomain.com'
    @from               = 'error@mydomain.com'
    @subject            = "Error message: #{env['REQUEST_URI']}" 
    @sent_on            = sent_on
    @body = {
      :exception => exception,
      :trace => trace,
      :session => session,
      :params => params,
      :env => env
    }
  end
end
#---
<!-- app/views/notification/error_message.rhtml -->

Time: <%= Time.now %>
Message: <%= @exception.message %>
Location: <%= @env['REQUEST_URI'] %>
Action: <%= @params.delete('action') %></td></tr>
Controller: <%= @params.delete('controller') %></td></tr>
Query: <%= @env['QUERY_STRING'] %></td></tr>
Method: <%= @env['REQUEST_METHOD'] %></td></tr>
SSL: <%= @env['SERVER_PORT'].to_i == 443 ? "true" : "false" %>
Agent: <%= @env['HTTP_USER_AGENT'] %>

Backtrace
<%= @trace.to_a.join("</p>\n<p>") %>

Params
<% @params.each do |key, val| -%>
* <%= key %>: <%= val.to_yaml %>
<% end -%>

Session
<% @session.each do |key, val| -%>
* <%= key %>: <%= val.to_yaml %>
<% end -%>

Environment
<% @env.each do |key, val| -%>
* <%= key %>: <%= val %>
<% end -%>
#---
