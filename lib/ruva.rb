require "ruva/version"
require "ruva/util"
require 'ruva/specification/specification'
require 'ruva/expression/expression_leaf_spec'
require 'ruva/expression/equal_greater_less'
require 'ruva/expression/identifier_comparable'
require 'ruva/expression/is_between'
require 'ruva/expression/matches'
require 'indentation-parser'
require 'citrus'
require 'ostruct'

Citrus.require 'ruva/expression/ruva_expression'

module Ruva::Expression::RuvaExpression
  def self.parse expression
    result = super expression
    result.value
  end
end

class Object
  def if condition
    raise unless block_given?
    spec = Ruva.interpret(Ruva.normalize_indentation condition)
    result = spec.evaluate self
    yield if result
    Ruva::Else.new result
  end
end

module Ruva

  def self.read file
    interpret IO.read("#{file}.ruva")
  end

  def self.interpret text

    parser = IndentationParser.new do |p|
      p.on /^all$/ do |parent, source, captures|
        node = Specification::AndSpec.new
        parent.append node
        node
      end

      p.on /^any$/ do |parent, source, captures|
        node = Specification::OrSpec.new
        parent.append node
        node
      end

      p.on /^none$/ do |parent, source, captures|
        node = Specification::NotSpec.new
        parent.append node
        node
      end

      p.else do |parent, source|
        node = Ruva::Expression::RuvaExpression.parse(source)
        parent.append node
        node
      end
    end

    spec = parser.read(text, Specification::AndSpec.new)
    spec.value
  end

  def self.normalize_indentation str
    if str.index(/^[ ]*$\n/) == 0
      str.sub!(/^[ ]*$\n/, "")
    end
    captures = /^\A([ ]*)/.match str
    first_indentation = captures[1]
    str.gsub!(/^#{first_indentation}/, "")
    str
  end

  # def self.hash_to_ostruct hash
  #   ostruct = OpenStruct.new
  #   hash.each do |key, value|
  #     if value.is_a? Hash
  #       ostruct.send("#{key}=", hash_to_ostruct(value))
  #     else
  #       ostruct.send("#{key}=", value)
  #     end
  #   end
  #   ostruct
  # end

  class Else
    def initialize satisfied
      @satisfied = satisfied
    end
    def else
      raise unless block_given?
      yield unless @satisfied
    end
  end
end
