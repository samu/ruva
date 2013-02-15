module ExpressionHelper
  def test_expression expression, input, expected
    spec = Ruva::Expression::RuvaExpression.parse(expression)
    result = spec.evaluate input
    result.should be expected
  end
end