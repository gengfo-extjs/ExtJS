require 'yaml'
configuration = { 'color' => 'blue',
                  'font' => 'Septimus',
                  'font-size'  => 7 }
open('text.cfg', 'w') { |f| YAML.dump(configuration, f) }

open('text.cfg') { |f| puts f.read }
# --- 
# font-size: 7
# color: blue
# font: Septimus

open('text.cfg') { |f| YAML.load(f) }
# => {"font-size"=>7, "color"=>"blue", "font"=>"Septimus"}
#---
configuration = [ { 'name' => 'Alice', 'donation' => 50 },
                  { 'name' => 'Bob', 'donation' => 15, 'currency' => "EUR" } ]
open('donors.cfg', 'w') { |f| YAML.dump(configuration, f) }
open('donors.cfg') { |f| puts f.read }
# ---
# - name: Alice
#   donation: 50
# - name: Bob
#   donation: 15
#   currency: EUR
#---
puts ({ 'measurements' => 'metric' }.to_yaml)
# --- 
# measurements: metric

puts ({ :measurements => :metric }.to_yaml)
# --- 
# :measurements: :metric
#---
