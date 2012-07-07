def create_matches_spec identifier, comparable
  comparable = comparable.value
  regex = comparable.is_a?(Regexp) ? comparable : Regexp.new(comparable)
  spec = ExpressionLeafSpec.new(identifier.value, regex)
  spec.set_validator { |value, *args|
    @comparable =~ value
  }
  spec.set_reporting { |satisfied, value, *args|
    comparable_string = "/#{@comparable.source}/"
    create_report_string "matches #{comparable_string}", "does not match #{comparable_string}", satisfied, value
  }
  spec
end

module Matches
  def value
    create_matches_spec identifier, comparable
  end
end

module ManyMatches
  def value
    spec = create_spec
    comparables.value.reverse.each do |comparable|
      new_spec = create_matches_spec identifier, comparable
      spec.append(new_spec)
    end
    spec
  end
end

module AndMatches include ManyMatches
  def create_spec
    AndSpec.new
  end
end

module OrMatches include ManyMatches
  def create_spec
    OrSpec.new
  end
end