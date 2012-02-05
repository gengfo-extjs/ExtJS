class IndexController < ApplicationController
  def index
    session[:first_time] ||= Time.now
  end
end
#---
<!-- index.rhtml -->
You first visited this site on <%= session[:first_time] %>. 

That was <%= time_ago_in_words session[:first_time] %> ago.
#---
class ApplicationController < ActionController::Base
  model :user, :ticket, :item, :history
end
#---
class IndexController < ApplicationController
  def index
    session[:user] ||= User.find(params[:id])
  end
end
#---
class ApplicationController < ActionController::Base
  session :off
end
#---
class MyController < ApplicationController
  session :off
end
#---
class MyController < ApplicationController
  session :off, :only => ['index']
  
  def index
    #This action will not have any sessions available to it
  end
end
#---
      flash[:error] = 'Invalid login.'
#---
Rails::Initializer.run do |config|
  config.action_controller.session_store = :active_record_store
end
#---
