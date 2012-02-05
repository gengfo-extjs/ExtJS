./script/generate model User
      exists  app/models/
      exists  test/unit/
      exists  test/fixtures/
      create  app/models/user.rb
      aardvark*create  test/unit/user_test.rb
      create  test/fixtures/users.yml*aardvark
      create  db/migrate
      create  db/migrate/001_create_users.rb
#---
./script/generate users list
      exists  app/controllers/
      exists  app/helpers/
      create  app/views/users
      exists  test/functional/
      create  app/controllers/users_controller.rb
      aardvark*create  test/functional/users_controller_test.rb*aardvark
      create  app/helpers/users_helper.rb
      create  app/views/users/list.rhtml
#---
$ rake
(in /home/lucas/mywebapp)
/usr/bin/ruby1.8 "test/unit/user_test.rb"
Started
.
Finished in 0.048702 seconds.

1 tests, 1 assertions, 0 failures, 0 errors
/usr/bin/ruby1.8 "test/functional/users_controller_test.rb"
Started
.
Finished in 0.024615 seconds.

1 tests, 1 assertions, 0 failures, 0 errors
#---
require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  fixtures :users

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
#---
class UserTest
  def test_first
    assert_kind_of User, users(:first)
  end
end
#---
first:
  id: 1
another:
  id: 2
#---
class UserTest
  def test_another
    assert_kind_of User, users(:another)
    assert_equal 2, users(:another).id
    assert_not_equal users(:first), users(:another)
  end
end
#---
