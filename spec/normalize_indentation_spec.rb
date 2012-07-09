require 'ruva'

describe Ruva do
  it "normalizes indentation" do
    indented_text = "
      this
        text
          is
            indented
    "
    indented_text = Ruva.normalize_indentation indented_text
    
    expected =
"this
  text
    is
      indented
    "
    
    indented_text.should eq expected
  end
end
