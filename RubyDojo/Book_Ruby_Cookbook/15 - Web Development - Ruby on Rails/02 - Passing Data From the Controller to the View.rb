class NovelController < ApplicationController
  def index
    @title = 'Shattered View: A Novel on Rails'
    one_plus_one = 1 + 1
    increment_counter one_plus_one
  end

  def helper_method
    @help_message = "I see you've come to me for help."   
  end

  private

  def increment_counter(by)
    @counter ||= 0
    @counter += by 
  end
end
#---
<h1><%= @title %></h1>

<p>I looked up, but saw only the number <%= @counter %>.</p>

<p>"What are you doing here?" I asked sharply. "Was it <%=
@counter.succ %> who sent you?"</p>
#---
class NovelController < ApplicationController
  @@numbers = [1, 2, 3]
  TITLE = 'Revenge of the Counting Numbers'
end
#---
# config/environment.rb
AUTHOR = 'Lucas Carlson'
#---
<h1><%= @title %></h1>
<p>by <%= AUTHOR %></p>
...
#---
$one = 1
class NovelController < ApplicationController
  $two = 2
  def sequel
    $three = 3
  end
end
#---
Here they come, the counting numbers, <%= $one %>, <%= $two %>, <%= $three %>.
#---
