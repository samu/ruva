require 'citrus'
require 'ostruct'
require 'ruva/specification'
require 'ruva/expression/expression_leaf_spec'
require 'ruva/expression/equal_greater_less'
require 'ruva/expression/identifier_comparable'
require 'ruva/expression/is_between'
require 'ruva/expression/matches'

Citrus.require 'ruva/expression/ruva_expression'

module Ruva::Expression::RuvaExpression
  def self.parse expression
    result = super expression
    result.value
  end
end