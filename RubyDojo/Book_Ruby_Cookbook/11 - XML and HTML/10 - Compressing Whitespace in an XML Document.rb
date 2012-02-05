require 'rexml/document'

text = %{<doc><a>Some      whitespace</a>    <b>Some   more</b></doc>}

REXML::Document.new(text, { :compress_whitespace => :all }).to_s
# => "<doc><a>Some whitespace</a> <b>Some more</b></doc>"
#---
REXML::Document.new(text, { :compress_whitespace => %w{a} }).to_s
# => "<doc><a>Some whitespace</a>    <b>Some   more</b></doc>"
#---
REXML::Document.new(text, { :respect_whitespace => %w{a} }).to_s
# => "<doc><a>Some      whitespace</a> <b>Some more</b></doc>"
#---
text = %{<doc><a>Some   text</a>\n  <b>Some   more</b>\n\n}
REXML::Document.new(text, { :compress_whitespace => :all }).to_s
# => "<doc><a>Some text</a>\n <b>Some more</b>\n</doc>"

REXML::Document.new(text, { :compress_whitespace => :all,
	                    :ignore_whitespace_nodes => :all }).to_s
# => "<doc><a>Some text</a><b>Some more</b></doc>"
#---
