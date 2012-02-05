require 'cookbook_dbconnect'
activerecord_connect

class Comment < ActiveRecord::Base
  @@profanity = %w{trot krip}
  @@no_profanity_re = Regexp.new('^(?!.*(' + @@profanity.join('|') + '))')

  validates_presence_of %w{author}
  validates_length_of :content, :in => 1..200
  validates_format_of :content, :with => @@no_profanity_re, 
                      :message => 'contains profanity'
end
#---
comment = Comment.create
comment.errors.on 'author'                       # => "can't be blank"
comment.errors['content']                        
# => "is too short (minimum is 1 characters)"
comment.save                                     # => false

comment = Comment.create(:content => 'x' * 1000)
comment.errors['content']                      
# => "is too long (maximum is 200 characters)"

comment = Comment.create(:author => 'Alice', 
  :content => "About what I'd expect from a trotting krip such as yourself!")
comment.errors.count                             # => 1
comment.errors.each_full { |msg| puts msg }      
# Content contains profanity

comment = Comment.create(:author => 'Alice', :content => 'I disagree!')
comment.save                                     # => true

#---
require 'cookbook_dbconnect'
activerecord_connect

class Comment < ActiveRecord::Base
  @@profanity = %w{trot krip}
  @@no_profanity_re = Regexp.new('^(?!.*(' + @@profanity.join('|') + '))')

  validates_presence_of %w{author}, :message => 'Please enter your name.'
  validates_length_of :content, :in => 1..200,
               :too_short => 'Please enter a comment.',
                      :too_long => 'Comments are limited to 200 characters.'
  validates_format_of :content, :with => @@no_profanity_re, 
                      :message => 'Try to express yourself without profanity.'
end
#---
