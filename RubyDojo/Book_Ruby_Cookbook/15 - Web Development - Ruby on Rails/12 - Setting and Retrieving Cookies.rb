class ApplicationController < ActionController::Base
  before_filter :count_visits
  
  private
  
  def count_visits
    value = (cookies[:visits] || '0').to_i
    cookies[:visits] = (value + 1).to_s
    @visits = cookies[:visits]
  end
end
#---
<!-- index.rhtml -->
You've visited this website's pages <%= @visits %> time(s).
#---
cookies[:user_id] = { :value => '123', :expires => Time.now + 1.hour} 
#---
cookies.delete :user_id
#---
