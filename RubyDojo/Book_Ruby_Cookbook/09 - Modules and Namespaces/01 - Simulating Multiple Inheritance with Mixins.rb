require 'set' # Deals with a collection of unordered values with no duplicates

# Include this module to make your class taggable. The names of the
# instance variable and the setup method are prefixed with "taggable_"
# to reduce the risk of namespace collision. You must call
# taggable_setup before you can use any of this module's methods.
module Taggable
  attr_accessor :tags

  def taggable_setup
    @tags = Set.new
  end

  def add_tag(tag)
    @tags << tag
  end

  def remove_tag(tag)
    @tags.delete(tag)
  end
end

module Taggable2
  def initialize(a,b,c)
  end
end

#---
class TaggableString < String
  include Taggable
  def initialize(*args)
    super
    taggable_setup
  end
end

s = TaggableString.new('It was the best of times, it was the worst of times.')
s.add_tag 'dickens'
s.add_tag 'quotation'
s.tags                               # => #<Set: {"dickens", "quotation"}>
#---
module Complaint 
  def gripe
    voice('In all my years I have never encountered such behavior...')
  end

  def faint_praise
    voice('I am pleased to notice some improvement, however slight...')
  end

  def voice(complaint_text)
    raise NotImplementedError,
    "#{self.class} included the Complaint module but didn't define voice!"
  end
end

class MyComplaint
  include Complaint
end

MyComplaint.new.gripe
# NotImplementedError: MyComplaint included the Complaint module
# but didn't define voice!
#---
module Ayto
  def potato
    'Pohtayto'
  end
end

module Ahto
  def potato
    'Pohtahto'
  end
end
#---
class Potato
  include Ayto
  include Ahto
end
#---
Potato.new.potato                                    # => "Pohtahto"
#---
