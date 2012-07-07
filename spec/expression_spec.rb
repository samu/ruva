require 'ruva/expression'

describe "Ruva::Expression" do
  
  it "evaluates whether age is 23" do
    spec = RuvaExpression.parse("age is 23")
    input = {:age => 23}
    result = spec.evaluate(input)
    puts spec.report result, input
  end
  
end