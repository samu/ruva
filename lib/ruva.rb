require 'indentation-parser'

require "ruva/version"
require "ruva/expression"

module Ruva
  def self.read file
    interpret IO.read("#{file}.ruva")
  end
  
  def self.interpret text
    parser = IndentationParser.new do |p|
      p.on /^all$/ do |parent, indentation, source, captures| 
        node = AndSpec.new
        parent.append node
        node
      end
      
      p.on /^any$/ do |parent, indentation, source, captures| 
        node = OrSpec.new
        parent.append node
        node
      end
      
      p.on /^none$/ do |parent, indentation, source, captures| 
        node = NotSpec.new
        parent.append node
        node
      end
      
      p.else do |parent, indentation, source|
        node = RuvaExpression.parse(source)
        parent.append node
        node
      end
    end
    spec = parser.read(text, AndSpec.new)
    spec.value
  end
end
