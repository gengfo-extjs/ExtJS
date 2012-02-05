:a_symbol.to_s                  # => "a_symbol"
:AnotherSymbol.id2name          # => "AnotherSymbol"
:"Yet another symbol!".to_s     # => "Yet another symbol!"
#---
:dodecahedron.object_id          # => 4565262
symbol_name = "dodecahedron"
symbol_name.intern               # => :dodecahedron
symbol_name.intern.object_id     # => 4565262
#---
"string".object_id     # => 1503030
"string".object_id     # => 1500330
:symbol.object_id      # => 4569358
:symbol.object_id      # => 4569358
#---
"string1" == "string2"        # => false
:symbol1 == :symbol2          # => false
#---
