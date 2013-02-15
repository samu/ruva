module Ruva
  module Util
    # This module provides functionality to perform deep method/attribute calls
    # on an object with a given string, such as 'this.is.a.deep.call'.
    module DeepCall
      def self.init_deep_call call_string, candidate
        deep_call(get_call_stack(call_string), to_open_struct(candidate))
      end

      def self.deep_call call_stack, candidate
        candidate = candidate.instance_eval(call_stack.pop)
        if (call_stack.size > 0)
          candidate = to_open_struct(candidate)
          return deep_call(call_stack, candidate)
        end
        candidate
      end

      def self.get_call_stack call_string
        call_string.split(".").reverse
      end

      def self.to_open_struct candidate
        candidate.is_a?(Hash) ? OpenStruct.new(candidate) : candidate
      end
    end
  end
end