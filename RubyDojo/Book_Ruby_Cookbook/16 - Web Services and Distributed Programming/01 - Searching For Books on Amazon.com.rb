require 'amazon/search'

$AWS_KEY = 'Your AWS key goes here' # See below.

def price_books(keyword)
  req = Amazon::Search::Request.new($AWS_KEY)
  req.keyword_search(keyword, 'books', Amazon::Search::LIGHT) do |product| 
    newp = product.our_price || 'Not available'
    usedp = product.used_price || 'not available'
    puts "#{product.product_name}: #{newp} new, #{usedp} used."
  end
end

price_books('ruby cookbook')
# Ruby Cookbook (Cookbooks (O'Reilly)): $31.49 new, not available used.
# Rails Cookbook (Cookbooks (O'Reilly)): $25.19 new, not available used.
# Ruby Ann's Down Home Trailer Park Cookbook: $10.85 new, $3.54 used.
# Ruby's Low-Fat Soul-Food Cookbook: Not available new, $12.43 used.
# ...
#---
http://xml.amazon.com/onca/xml3?KeywordSearch=ruby+cookbook&mode=books...
#---
<?xml version="1.0" encoding="UTF-8"?>
<ProductInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
 xsi:noNamespaceSchemaLocation="http://xml.amazon.com/schemas3/dev-lite.xsd">
...
 <TotalResults>11</TotalResults>
  <TotalPages>2</TotalPages>

   <Details url="http://www.amazon.com/exec/obidos/ASIN/0596523696/">
     <ProductName>Ruby Cookbook</ProductName>
     <Catalog>Book</Catalog>
     <Authors>
       <Author>Lucas Carlson</Author>
       <Author>Leonard Richardson</Author>
     </Authors>
     <ReleaseDate>September, 2006</ReleaseDate>
     <Manufacturer>O'Reilly Media</Manufacturer>
...
   </Details> 
...
</ProductInfo>
#---
