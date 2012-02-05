class String
  def mgsub(key_value_pairs=[].freeze)
    regexp_fragments = key_value_pairs.collect { |k,v| k }
    gsub(Regexp.union(*regexp_fragments)) do |match|
      key_value_pairs.detect{|k,v| k =~ match}[1]
    end	
  end
end

#---
"GO HOME!".mgsub([[/.*GO/i, 'Home'], [/home/i, 'is where the heart is']])
# => "Home is where the heart is!"
#---
"Here is number #123".mgsub([[/[a-z]/i, '#'], [/#/, 'P']])
# => "#### ## ###### P123"
#---
"FOO bar".gsub(/foo/i, "The bar").gsub(/bar/m, "result")
# => "The result result"

"Here is number #123".gsub(/[a-z]/i, "#").gsub(/#/, "P")
# => "PPPP PP PPPPPP P123"
#---
"between".mgsub(/ee/ => 'AA', /e/ => 'E')        # Bad code
# => "bEtwEEn"

"between".mgsub([[/ee/, 'AA'], [/e/, 'E']])      # Good code
# => "bEtwAAn"
#---
