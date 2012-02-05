require 'rexml/document'

REXML::Document.new(xml)
#---
require 'rexml/document'
include REXML

Document.new(xml)
#---
require 'rexml/parsers/pullparser'

REXML::Parsers::PullParser.new("Some XML")
#---
require 'rexml/parsers/pullparser'
include REXML::Parsers

PullParser.new("Some XML")
#---
