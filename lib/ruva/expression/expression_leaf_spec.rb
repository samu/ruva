module Ruva
  module Expression
    class LeafSpec
      def initialize name, args
        @name = name
        @comparable = args
      end

      def set_validator &block
        @validator = block
      end

      def set_reporting &block
        @reporting = block
      end

      def evaluate *args
        instance_exec(get_value(*args), *args, &@validator)
      end

      # def report satisfied, *args
      #   instance_exec(satisfied, get_value(*args), *args, &@reporting)
      # end
    end

    class ExpressionLeafSpec < LeafSpec
      def get_value value
        Ruva::Util::DeepCall.init_deep_call(@name, value)
      end

      # def create_typed_value value
      #   case value
      #     when Numeric then value
      #     when String then "'#{value}'"
      #     else value
      #   end
      # end

      # def create_report_string positive, negative, satisfied, value
      #   @name.to_s + " #{create_typed_value value} " + (satisfied ? positive : negative)
      # end
    end
  end
end