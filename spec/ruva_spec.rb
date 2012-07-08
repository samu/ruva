require 'ruva'
require 'ostruct'

describe Ruva do
  it "reads .ruva files" do
    spec = Ruva.read "spec/simple_condition"
    
    input = OpenStruct.new
    input.age = 23
    input.name = "samuel"
    input.profession = "application engineer"
    input.city = "zurich"
    
    result = spec.evaluate(input)
    
    result.satisfied.should be true
    puts result
  end
end
