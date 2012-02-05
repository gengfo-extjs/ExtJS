# The FooController controller contains miscellaneous functionality
# rejected from other controllers.
class FooController < ApplicationController
  # The set_random action sets the @random_number instance variable 
  # to a random number.
  def set_random
    @random_number = rand*rand
  end
end
#---
$ rake appdoc
#---
