use mywebapp_development;
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `hashed_password` VARCHAR(40) NOT NULL,
  PRIMARY KEY (id)
);
#---
require 'sha1'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_protected :hashed_password
  validates_uniqueness_of :username
  validates_confirmation_of :password,
    :if => lambda { |user| user.new_record? or not user.password.blank? }
  validates_length_of :password, :within => 5..40,
    :if => lambda { |user| user.new_record? or not user.password.blank? }
  
  def self.hashed(str)
    SHA1.new(str).to_s
  end
    
  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(user_info)
    user = find_by_username(user_info[:username])
    if user && user.hashed_password == hashed(user_info[:password])
      return user
    end
  end

  private
  before_save :update_password

  # Updates the hashed_password if a plain password was provided.
  def update_password
    if not password.blank?
      self.hashed_password = self.class.hashed(password)
    end
  end
end
#---
