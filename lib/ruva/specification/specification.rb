module Ruva
  module Specification
    class Spec
      def initialize
        @specs = Array.new
      end

      def append spec
        @specs << spec
        spec
      end

      # def create_subreport spec, *args
      #   if spec.is_a? Spec
      #     spec.evaluate *args
      #   else
      #     result = spec.evaluate *args
      #     message = spec.report result, *args
      #     SpecReport.new result, message
      #   end
      # end

      # def report satisfied, *args
      #   report = SpecReport.new false, name
      #   @specs.each do |spec|
      #     subreport = create_subreport spec, *args
      #     report.add_subreport subreport
      #     if condition_change? subreport.satisfied
      #       passed = !initial_condition
      #     end
      #   end
      #   report.satisfied = passed
      #   report
      # end

      def evaluate value
        passed = initial_condition
        @specs.each do |spec|
          result = spec.evaluate value
          if condition_change? result
            passed = !initial_condition
          end
        end
        passed
      end
    end

    class AndSpec < Spec
      def initial_condition() return true end
      def name() "all" end
      def condition_change?(satisfied) !satisfied end
    end

    class OrSpec < Spec
      def initial_condition() return false end
      def name() "any" end
      def condition_change?(satisfied) satisfied end
    end

    class NotSpec < Spec
      def initial_condition() return true end
      def name() "none" end
      def condition_change?(satisfied) satisfied end
    end



    # class SpecReport

    #   attr_accessor :satisfied, :name, :input

    #   def initialize satisfied, message
    #     @satisfied = satisfied
    #     @message = message
    #     @subreports = Array.new
    #   end

    #   def add_subreport subreport
    #     @subreports << subreport
    #   end

    #   def to_s s = ''
    #     met = @satisfied ? "[+] " : "[-] "
    #     output = s + met + @message
    #     output += "\n"
    #     @subreports.each do |subreport|
    #       output += subreport.to_s(s + '  ')
    #     end
    #     output
    #   end
    # end
  end
end