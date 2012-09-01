require 'ruva'

describe Ruva do
  it "turns a hash into an ostruct" do
    person = OpenStruct.new
    person.name = "sam"
    person.age = 23
    hash = {
      :this => {
        :ostruct => person,
        :is => {
          :a => {
            :test => "works!"
          }
        }
      }
    }
    ostruct = Ruva.hash_to_ostruct hash
    ostruct.this.is.a.test.should eq "works!"
    ostruct.this.ostruct.name.should eq "sam"
    ostruct.this.ostruct.age.should eq 23
  end
end
