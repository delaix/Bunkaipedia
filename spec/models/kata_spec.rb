require 'spec_helper'

describe Kata do
  before(:each) do
    @attributes = { :name => "Passai sho" }
  end
  
  it "should have a name" do
    Kata.new(@attributes).should respond_to(:name)
  end
  
  it "should have techniques" do
    Kata.new(@attributes).should respond_to(:techniques)
  end
  
  it "should have bunkais" do
    Kata.new(@attributes).should respond_to(:bunkais)
  end
  
  describe "contents" do
    before(:each) do
      @style = Factory(:style)
    end
    
    it "should contain the expected techniques" do
      kata = @style.katas.create(@attributes)
      @technique_1 = Factory(:technique, :kata => kata)
      @technique_2 = Factory(:technique, :kata => kata, :description => "reverse punch")
      kata.techniques.should == [@technique_1, @technique_2]
    end
    
    it "should validate its name" do
      kata = @style.katas.build(@attributes).should be_valid
      kata = @style.katas.build(@attributes.merge(:name => 'x' * 65)).should_not be_valid
    end
  end
end
