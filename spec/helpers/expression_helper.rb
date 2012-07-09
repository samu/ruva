module ExpressionHelper
  def test_expression expression, input, expected
    spec = RuvaExpression.parse(expression)
    result = spec.evaluate input
    result.should be expected
  end
end