require 'yaml'

10.to_yaml                   # => "--- 10\n"
'ten'.to_yaml                # => "--- ten\n"
'10'.to_yaml                 # => "--- \"10\"\n"
#---
puts %w{Brush up your Shakespeare}.to_yaml
# ---
# - Brush
# - up
# - your
# - Shakespeare
#---
puts ({ 'star' => 'hydrogen', 'gold bar' => 'gold' }).to_yaml
# ---
# star: hydrogen
# gold bar: gold
#---
require 'set'
puts Set.new([1, 2, 3]).to_yaml
# --- !ruby/object:Set
# hash:
#  1: true
#  2: true
#  3: true
#---
users = [{:name => 'Bob', :permissions => ['Read']},
         {:name => 'Alice', :permissions => ['Read', 'Write']}]

# Serialize
open('users', 'w') { |f| YAML.dump(users, f) }

# And deserialize
users2 = open("users") { |f| YAML.load(f) }
# => [{:permissions=>["Read"], :name=>"Bob"}, 
#     {:permissions=>["Read", "Write"], :name=>"Alice"}]
#---
quiz_question = ['What color is Raedon?', ['Blue', 'Albino', '*Yellow']]
puts quiz_question.to_yaml
# ---
# - What color is Raedon?
# - - Blue
#   - Albino
#   - "*Yellow"
#---
require 'yaml'
require 'set'
set = Set.new([1, 2, 3])
open("set", "w") { |f| YAML.dump(set, f) } 
#---
# Bad code -- don't try this!
require 'yaml'
set = open("set") { |f| YAML.load(f) }
# => #<YAML::Object:0xb7bd8620 @ivars={"hash"=>{1=>true, 2=>true, 3=>true}}, 
#      @class="Set">
#---
handle = open('a_file', 'w')
handle.path
# => "a_file"

handle2 = YAML.load(YAML.dump(handle))
# => #<File:0xb7bd9a58>
handle2.path
# IOError: uninitialized stream
#---
