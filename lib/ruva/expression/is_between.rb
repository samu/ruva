def create_is_spec identifier, comparable
  spec = ExpressionLeafSpec.new(identifier.value, comparable.value) 
  spec.set_validator { |value, *args|
    @comparable == value
  }
  spec.set_reporting { |satisfied, value, *args|
    comparable_string = @comparable.to_s
    create_report_string "is #{comparable_string}", "is not #{comparable_string}", satisfied, value
  }
  spec
end

module Is
  def value
    create_is_spec identifier, comparable
  end
end

module ManyIs
  def value
    spec = create_spec
    comparables.value.reverse.each do |comparable|
      new_spec = create_is_spec identifier, comparable
      spec.append(new_spec)
    end
    spec
  end
end

module OrIs include ManyIs
  def create_spec
    OrSpec.new
  end
end

module IsBetween
  def value
    comparables = [from.value, to.value]
    spec = ExpressionLeafSpec.new(identifier.value, comparables) 
    spec.set_validator { |value, *args|
      @comparable[0] <= value && @comparable[1] >= value
    }
    spec.set_reporting { |satisfied, value, *args|
      comparable_string = "#{@comparable[0]} and #{@comparable[1]}" 
      create_report_string "is between #{comparable_string}", "is not between #{comparable_string}", satisfied, value
    }
    spec
  end
end