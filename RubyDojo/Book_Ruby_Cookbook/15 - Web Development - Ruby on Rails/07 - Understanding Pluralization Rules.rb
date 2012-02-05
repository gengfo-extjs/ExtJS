class Order < ActiveRecord::Base
  has_many :line_items
end
#---
Rails::Initializer.run do |config|
  config.active_record.pluralize_table_names = false
end
#---
Inflector.inflections do |inflect|
  inflect.plural /^(foo)$/i, '\1ze'
  inflect.singular /^(foo)ze/i, '\1'
end
#---
Inflector.inflections do |inflect|
  inflect.irregular 'foo', 'fooze'
end
#---
Inflector.inflections do |inflect|
  inflect.uncountable ['status', 'furniture', 'fish', 'sheep']
end
#---
require 'rubygems'
require 'active_support/core_ext'

'blob'.pluralize                                 # => "blobs"
'child'.pluralize                                # => "children"
'octopus'.pluralize                              # => "octopi"
'octopi'.singularize                             # => "octopus"
'people'.singularize                             # => "person"

'goose'.pluralize                                # => "gooses"
Inflector.inflections { |i| i.irregular 'goose', 'geese' }
'goose'.pluralize                                # => "geese"

'moose'.pluralize                                # => "mooses"
Inflector.inflections { |i| i.uncountable 'moose' }
'moose'.pluralize                                # => "moose"
#---
