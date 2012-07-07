class GreaterSpec < ExpressionLeafSpec
  def compare (comparable, value) value > comparable end
  def satisfied_text() "greater than" end
  def unsatisfied_text() "less than" end
end

class LessSpec < ExpressionLeafSpec
  def compare (comparable, value) value < comparable end
  def satisfied_text() "less than" end
  def unsatisfied_text() "greater than" end
end

class GreaterEqualSpec < ExpressionLeafSpec
  def compare (comparable, value) value >= comparable end
  def satisfied_text() "greater than or equal to" end
  def unsatisfied_text() "less than" end
end

class LessEqualSpec < ExpressionLeafSpec
  def compare (comparable, value) value <= comparable end
  def satisfied_text() "less than or equal to" end
  def unsatisfied_text() "greater than" end
end

module EqualGreaterLess
  def value
    spec = create_spec
    spec.set_validator { |value, *args| 
      compare @comparable, value
    }
    spec.set_reporting { |satisfied, value, *args|
      comparable_string = @comparable.to_s
      create_report_string "is #{satisfied_text} #{comparable_string}", "is #{unsatisfied_text} #{comparable_string}", satisfied, value
    }
    spec
  end
end

module Greater include EqualGreaterLess
  def create_spec
    GreaterSpec.new(identifier.value, comparable.value) 
  end
end

module Less include EqualGreaterLess
  def create_spec
    LessSpec.new(identifier.value, comparable.value) 
  end
end

module GreaterOrEqual include EqualGreaterLess
  def create_spec
    GreaterEqualSpec.new(identifier.value, comparable.value) 
  end
end

module LessOrEqual include EqualGreaterLess
  def create_spec
    LessEqualSpec.new(identifier.value, comparable.value) 
  end
end