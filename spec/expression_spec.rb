require 'ruva/expression'
require 'helpers/expression_helper'

RSpec.configure do |c|
  c.include ExpressionHelper
end

describe Ruva do

  describe "is/between expressions" do
    it "handles numerics" do
      test_expression "ary[0] is 10", {:ary => [10, 11, 12]}, true

      test_expression "age is 23", {:age => 23}, true
      test_expression "age is 23", {:age => 24}, false
      test_expression "age is 23 or 24 or 25", {:age => 24}, true

      test_expression "age is between 18 and 28", {:age => 23}, true
      
      test_expression "age is between 18 and 28", {:age => 28}, true
      test_expression "age is between 18 and 28", {:age => 18}, true
      
      test_expression "age is between 18 and 28", {:age => 50}, false
      test_expression "age is between 18 and 28", {:age => 17}, false
    end

    it "handles strings" do
      test_expression "name is samuel", {:name => "samuel"}, true
      test_expression "name is samuel", {:name => "melchior"}, false
      test_expression "name is sam", {:name => "samuel"}, false

      test_expression "letter is between a and c", {:letter => "b"}, true
      test_expression "letter is between a and c", {:letter => "d"}, false
      test_expression "city is between zue and zur", {:city => "zuf"}, true
      test_expression "city is between zue and zur", {:city => "zua"}, false
    end

    it "handles dates" do
      test_expression "date is 02.02.2002", {:date => Date.parse("2.2.2002")}, true
      test_expression "date is between 01.01.2000 and 31.12.2000", {:date => Date.parse("1.7.2000")}, true
      test_expression "date is between 01.01.2000 and 31.12.2000", {:date => Date.parse("1.7.2001")}, false
    end
  end

  describe "greater/less/equal expressions" do
    it "handles numerics" do
      test_expression "age is greater than 23", {:age => 24}, true
      test_expression "age is greater than 23", {:age => 23}, false
      
      test_expression "age is less than 23", {:age => 22}, true
      test_expression "age is less than 23", {:age => 23}, false
      
      test_expression "age is greater than or equal to 23", {:age => 23}, true
      test_expression "age is greater than or equal to 23", {:age => 22}, false
      
      test_expression "age is less than or equal to 23", {:age => 23}, true
      test_expression "age is less than or equal to 23", {:age => 24}, false

      test_expression "age is 23 or more", {:age => 23}, true
      test_expression "age is 23 or more", {:age => 22}, false
      test_expression "age is 23 or more", {:age => 24}, true
      
      test_expression "age is 23 or less", {:age => 23}, true
      test_expression "age is 23 or less", {:age => 24}, false
      test_expression "age is 23 or less", {:age => 22}, true
    end
    
    it "handles strings" do      
      test_expression "name is greater than samuel", {:name => "simon"}, true
      test_expression "name is greater than samuel", {:name => "samantha"}, false
      
      test_expression "name is less than samuel", {:name => "lisa"}, true
      test_expression "name is less than samuel", {:name => "samuel l jackson"}, false
      
      test_expression "name is greater than or equal to samuel", {:name => "samuel"}, true
      test_expression "name is greater than or equal to samuel", {:name => "samantha"}, false
      
      test_expression "name is less than or equal to samuel", {:name => "samuel"}, true
      test_expression "name is less than or equal to samuel", {:name => "samuel l jackson"}, false
    end
    
    it "handes dates" do
      test_expression "date is greater than 01.01.2011", {:date => Date.parse("1.1.2012")}, true
      test_expression "date is greater than 01.01.2011", {:date => Date.parse("1.1.2010")}, false

      test_expression "date is less than 01.01.2011", {:date => Date.parse("1.1.2010")}, true
      test_expression "date is less than 01.01.2011", {:date => Date.parse("1.1.2012")}, false

      test_expression "date is greater than or equal to 01.01.2011", {:date => Date.parse("1.1.2012")}, true
      test_expression "date is greater than or equal to 01.01.2011", {:date => Date.parse("1.1.2010")}, false

      test_expression "date is less than or equal to 01.01.2011", {:date => Date.parse("1.1.2010")}, true
      test_expression "date is less than or equal to 01.01.2011", {:date => Date.parse("1.1.2012")}, false
    end
  end
  
  describe "matches expressions" do
    it "handles strings" do
      test_expression "name matches sam", {:name => "samuel"}, true
      test_expression "name matches am", {:name => "samuel"}, true
      test_expression "name matches uel", {:name => "samuel"}, true
      
      test_expression "name matches xyz", {:name => "samuel"}, false
      
      test_expression "name matches /^samuel$/", {:name => "samuel"}, true
      test_expression "name matches /^samuel$/", {:name => "samuel "}, false
      
      test_expression "name matches /daniel|jonas/", {:name => "daniel"}, true
      test_expression "name matches /daniel|jonas/", {:name => "jonas"}, true
      
      test_expression 'name matches /regex\/with escaping/', {:name => "regex/with escaping"}, true
      test_expression "name matches /regex\\/with escaping/", {:name => "regex/with escaping"}, true
    end
  end

  describe "misc functions" do
    it "handles deep attributes" do
      obj = {
        :person => {
          :address => {
            :zip => 12345
          }
        }
      }
      test_expression "person.address.zip is 12345", obj, true

      obj = OpenStruct.new
      person = OpenStruct.new
      person.address = {
        :zip => 12345
      }
      obj.person = person
      test_expression "person.address.zip is 12345", obj, true
    end
  end
  
end