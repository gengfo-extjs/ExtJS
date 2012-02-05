class SecretNumber
  def initialize
    @secret = rand(20)
  end

  def hint
    puts "The number is #{"not " if secret <= 10}greater than 10."
  end

  private 
  def secret
    @secret
  end
end

s = SecretNumber.new
s.secret
# NoMethodError: private method `secret' called for 
#  #<SecretNumber:0xb7c2e83c @secret=19>

s.hint
# The number is greater than 10.
#---
class LessSecretNumber < SecretNumber
  def hint
    lower = secret-rand(10)-1
    upper = secret+rand(10)+1
    "The number is somewhere between #{lower} and #{upper}."
  end
end

ls = LessSecretNumber.new
ls.hint
# => "The number is somewhere between -3 and 16."
ls.hint
# => "The number is somewhere between -1 and 15."
ls.hint
# => "The number is somewhere between -2 and 16."
#---
class MyClass
  def public_method1
  end

  def public_method2
  end

  protected
  
  def protected_method1
  end

  private

  def private_method1
  end

  def private_method2
  end
end
#---
class LessSecretNumber
  def compare(other)
    if secret == other.secret
    comparison = "equal to" 
    else
      comparison = secret > other.secret ? "greater than" : "less than"
    end
    "This secret number is #{comparison} the secret number you passed in."
  end  
end

a = LessSecretNumber.new
b = LessSecretNumber.new
a.hint
# => "The number is somewhere between 17 and 22."
b.hint
# => "The number is somewhere between 0 and 12."
a.compare(b)
# NoMethodError: private method `secret' called for 
# #<LessSecretNumber:0xb7bfe13c @secret=6>
#---
class SecretNumber
  protected :secret
end
a.compare(b)
# => "This secret number is greater than the secret number you passed in."
b.compare(a)
# => "This secret number is less than the secret number you passed in."
#---
class MethodWithManySecrets
  :private
  
  # This method will show up in the RDoc, even though it's private.
  def secret_method_1
  end

  # This method will not show up in the RDoc.
  def secret_method_2 # :nodoc:
  end
end
#---
s.send(:secret)                                # => 19 
#---
