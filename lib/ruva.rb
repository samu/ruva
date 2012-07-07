require 'indentation-interpreter'

require "ruva/version"
require "ruva/expression"

module Ruva
  def self.read text
    parser = IndentationInterpreter.new do |p|
      
      p.on /^all$/ do |node| 
        node.set_value AndSpec.new
        node.parent.value.append node.value
      end
      
      p.on /^any$/ do |node| 
        node.set_value OrSpec.new
        node.parent.value.append node.value
      end
      
      p.on /^none$/ do |node| 
        node.set_value OrSpec.new
        node.parent.value.append node.value
      end
      
      p.else do |node|
        node.set_value RuvaExpression.parse(node.source)
        node.parent.value.append node.value
      end
      
    end
    
    spec = parser.read(text, AndSpec.new)
    spec.value
  end
end
