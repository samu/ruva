module Identifier
  def value
    to_s.strip
  end
end

module Comparable
  def value
    to_s
  end
end

module LastComparable
  def value   
    Array.new << comparable
  end
end

module IntComparable
  def value
    to_i
  end
end

module FloatComparable
  def value
    to_f
  end
end

module DateComparable
  def value
    Date.parse to_s
  end
end

module RegexComparable
  def value
    Regexp.new regex.value
  end
end

module TextComparable
  def value
    return to_s.strip
  end
end

module Comparables
  def value
    subresult.value << comparable
  end
end