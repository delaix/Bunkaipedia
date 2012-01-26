require 'spec_helper'

describe Style do
  before(:each) do
    @attributes = { :name => "Shobayashi ryu" }
  end
  
  it "should reference katas" do
    Style.new(@attributes).should respond_to(:katas)
  end
  
  it "should contain kata" do
    style = Style.new(@attributes)
    style.save
    kata = style.katas.create(:name => "Passai sho")
    style.katas.include?(kata).should be_true
  end
end
