class Recipe
  # ... The rest of the Recipe implementation goes here.
  def cook(stove, cooking_time)
    dish = prepare_ingredients
    stove << dish
    wait_for(cooking_time)
    return dish
  end
end
#---
class RecipeWithExtraGarlic < Recipe
  def cook(stove, cooking_time)

    5.times { add_ingredient(Garlic.new.chop) }
    super
  end
end
#---
class BakingRecipe < Recipe
  def cook(cooking_time, oven_temperature=350)
    oven = Oven.new(oven_temperature)
    super(oven, cooking_time)
  end
end
#---
class MyString < String
  def gsub(*args)
    return "#{super} -- This string modified by MyString#gsub (TM)"
  end
end

str = MyString.new("Here's my string")
str.gsub("my", "a")
# => "Here's a string -- This string modified by MyString#gsub (TM)"

str.gsub(/m| s/) { |match| match.strip.capitalize }
# => "Here's MyString -- This string modified by MyString#gsub (TM)"
#---
class MyString
  def succ!(skip=1)
    skip.times { super() }
    self
  end
end

str = MyString.new('a')
str.succ!(3)                        # => "d"
#---
class MyFile < File
  def MyFile.ftype(*args)
    return "The type is #{super}."
  end
end

File.ftype("/bin")                        # => "directory"
MyFile.ftype("/bin")                      # => "The type is directory."
```#---
