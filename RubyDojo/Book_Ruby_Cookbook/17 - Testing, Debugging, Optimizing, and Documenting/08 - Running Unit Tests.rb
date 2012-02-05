# person_test.rb
require File.join(File.dirname(__FILE__), '..', 'app', 'person')
require 'test/unit'

class PersonTest < Test::Unit::TestCase
  FIRST_NAME, LAST_NAME, AGE = 'Nathaniel', 'Talbott', 25

  def setup
    @person = Person.new(FIRST_NAME, LAST_NAME, AGE)
  end

  def test_first_name
    assert_equal FIRST_NAME, @person.first_name
  end

  def test_last_name
    assert_equal LAST_NAME,  @person.last_name
  end

  def test_full_name
    assert_equal FIRST_NAME + ' ' + LAST_NAME, @person.full_name
  end

  def test_age
    assert_equal 25, @person.age
    assert_raise(ArgumentError) { Person.new(FIRST_NAME, LAST_NAME, -4) }
    assert_raise(ArgumentError) { Person.new(FIRST_NAME, LAST_NAME, 'four') }
  end
end
#---
$ ruby test/person_test.rb 
Loaded suite test/person_test
Started
....
Finished in 0.008955 seconds.

4 tests, 6 assertions, 0 failures, 0 errors
#---
$ ruby test/person_test.rb --verbose --name test_first_name \
  --name test_last_name
Loaded suite test/person_test
Started
test_first_name(PersonTest): .
test_last_name(PersonTest): .

Finished in 0.012567 seconds.

2 tests, 2 assertions, 0 failures, 0 errors
#---
$ tail -5 /usr/local/lib/ruby/1.8/test/unit.rb
at_exit do
  unless $! || Test::Unit.run?
    exit Test::Unit::AutoRunner.run
  end
end
#---
$ ruby test/person_test.rb --verbose --name '/test_f/'
Loaded suite test/person_test
Started
test_first_name(PersonTest): .
test_full_name(PersonTest): .

Finished in 0.014891 seconds.

2 tests, 2 assertions, 0 failures, 0 errors
#---
$ ruby -rtest/unit -e0 -- --pattern '/_test/'
Loaded suite .
Started
...
Finished in 0.009329 seconds.

4 tests, 6 assertions, 0 failures, 0 errors
#---
$ ruby test/person_test.rb --help
#---
$ ruby -rtest/unit -e0 -- --help
#---
