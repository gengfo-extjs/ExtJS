$KCODE = 'u' # This lets us parse UTF characters
require 'soap/wsdlDriver'

class Google
  @@key = 'JW/JqyXMzCsv7k/dxqR9E9HF+jiSgbDL' # get your key at http://www.google.com/apis/
  @@driver = SOAP::WSDLDriverFactory.
	new('http://api.google.com/GoogleSearch.wsdl').create_rpc_driver

 def self.search(query, options={})
    @@driver.doGoogleSearch(
      @@key,
      query,
      options[:offset] || 0,
      options[:limit] || 10,       # Note that this value cannot exceed 10
      options[:filter] || true,
      options[:restricts] || ' ',
      options[:safe_search] || false,
      options[:lr] || ' ',
      options[:ie] || ' ',
      options[:oe] || ' '
    ) 
  end

  def self.count(query, options={})
    search(query, options).estimatedTotalResultsCount
  end

  def self.spell(phrase)
    @@driver.doSpellingSuggestion(@@key, phrase)
  end
end
#---
Google.count "Ruby Cookbook site:oreilly.com"
# => 368

results = Google.search "Ruby Cookbook site:oreilly.com", :limit => 7
results.resultElements.size
# => 7

results.resultElements.first["title"]
# => "oreilly.com -- Online Catalog: <b>Ruby Cookbook</b>..."

results.resultElements.first["URL"]
# => "http://www.oreilly.com/catalog/rubyckbk/"

results.resultElements.first["snippet"]
# => "The <b>Ruby Cookbook</b> is a new addition to ..."

Google.spell "tis is te centence"
# => "this is the sentence"
#---
