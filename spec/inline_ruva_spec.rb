require 'ruva'
require 'ostruct'

describe Ruva do
  describe "the 'if' syntax" do
    
    before :all do
      @person = OpenStruct.new
      @person.age = 23 
      @person.city = "zurich"
      @person.name = "samuel" 
    end
    
    it "handles one liners" do      
      #person.if "age is 23 or higher" <-- TODO: support this    
      executed = false    
      @person.if "age is 23" do 
        executed = true
      end
      executed.should be true
      
      executed = false
      @person.if("age is 23") {
        executed = true
      }.else {
        true.should be false
      }
      executed.should be true
      
      executed = true
      @person.if("age is 24") {
        true.should be false
      }.else {
        executed = false
      }
      executed.should be false
    end
    
    it "handles multi line conditions" do 
      
      executed = false
      @person.if "
        age is 23
        city is zurich
        name is samuel
      " do
        executed = true
      end
      executed.should be true
      
      executed = true
      @person.if("
        age is 24
        city is zurich
        name is samuel
      ") {
        true.should be false
      }.else {
        executed = false
      }
      executed.should be false
      
    end
  end
end