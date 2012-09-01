class ExpressionLeafSpec < LeafSpec
  def get_value *args
    if (args.size == 1)
      obj = args[0]
      if (obj.is_a? Hash)
        get_hash_value @name.split(".").reverse, obj
      else
        get_object_value @name.split(".").reverse, obj
      end
    else
      raise "Unexpected input"
    end   
  end

  def get_hash_value key_array, hash
    if (key_array.size > 1)
      obj = hash[key_array.pop.to_sym]
      if (obj.is_a?(Hash)) 
        get_hash_value(key_array, obj)
      else
        get_object_value(key_array, obj)
      end
    else
      obj = OpenStruct.new hash
      obj.instance_eval(key_array.pop)
    end
  end
  
  def get_object_value key_array, obj
    if (key_array.size > 1)
      obj = obj.send key_array.pop
      if (obj.is_a?(Hash)) 
        get_hash_value(key_array, obj)
      else
        get_object_value(key_array, obj)
      end
    else
      obj.instance_eval(key_array.pop)
    end
  end
  
  def create_typed_value value
    case value
      when Numeric then value
      when String then "'#{value}'"
      else value
    end
  end
  
  def create_report_string positive, negative, satisfied, value  
    @name.to_s + " #{create_typed_value value} " + (satisfied ? positive : negative)
  end
end
