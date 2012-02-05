use mywebapp_development;
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`)
);
#---
$ ./script/generate model User
      exists  app/models/
      exists  test/unit/
      exists  test/fixtures/
      create  app/models/user.rb
      create  test/unit/user_test.rb
      create  test/fixtures/users.yml
#---
class User < ActiveRecord::Base
  validates_uniqueness_of :username
  validates_confirmation_of :password, :on => :create
  validates_length_of :password, :within => 5..40
  
  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(user_info)
    find_by_username_and_password(user_info[:username], 
                                  user_info[:password])
  end
end
#---
$ ./script/generate controller user login process_login logout my_account
      exists  app/controllers/
      exists  app/helpers/
      create  app/views/user
      exists  test/functional/
      create  app/controllers/user_controller.rb
      create  test/functional/user_controller_test.rb
      create  app/helpers/user_helper.rb
      create  app/views/user/login.rhtml
      create  app/views/user/process_login.rhtml
      create  app/views/user/logout.rhtml
#---
class UserController < ApplicationController
  def login
    @user = User.new
    @user.username = params[:username]
  end
  
  def process_login
    if user = User.authenticate(params[:user])
      session[:id] = user.id # Remember the user's id during this session
      redirect_to session[:return_to] || '/'
    else
      flash[:error] = 'Invalid login.'
      redirect_to :action => 'login', :username => params[:user][:username]
    end
  end
  
  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :action => 'login'
  end

  def my_account
  end
end
#---
<!-- app/views/user/login.rhtml -->
<% if @flash[:message] %><div><%= @flash[:message] %></div><% end %>
<% if @flash[:error] %><div><%= @flash[:error] %></div><% end %>

<%= form_tag :action => 'process_login' %>
 Username: <%= text_field "user", "username" %><br />
  Password: <%= password_field "user", "password" %><br />
  <%= submit_tag %>
<%= end_form_tag %>
#---
<!-- app/views/user/my_account.rhtml -->
<h1>Account Info</h1>

<p>Your username is <%= User.find(session[:id]).username %>
#---
$ ./script/runner 'User.create(:username => "johndoe", \
                               :password => "changeme")'
#---
class ApplicationController < ActionController::Base
  before_filter :set_user

protected
  def set_user
    @user = User.find(session[:id]) if @user.nil? && session[:id]
  end

  def login_required
    return true if @user
    access_denied
    return false
  end

  def access_denied
    session[:return_to] = request.request_uri
    flash[:error] = 'Oops. You need to login before you can view that page.'
    redirect_to :controller => 'user', :action => 'login'
  end
end
#---
class UserController < ApplicationController
  before_filter :login_required, :only => :my_account
end
#---
