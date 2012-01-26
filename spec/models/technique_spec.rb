require 'spec_helper'

describe Technique do
  before(:each) do
    @attributes = { :description => "Front kick" }
  end
  
  it "should have an image" do
    Technique.new(@attributes).should respond_to(:image)
  end
  
  it "should have a kata" do
    Technique.new(@attributes).should respond_to(:kata)
  end
  
  it "should have bunkais" do
    Technique.new(@attributes).should respond_to(:bunkais)
  end
  
  describe "content" do
    before(:each) do
      @kata = Factory.create(:kata)
      @technique = @kata.techniques.create(@attributes)
    end
    
    it "should refer to the correct kata" do
      @technique.kata.should == @kata
    end
    
    it "should have the correct image" do
      image = Factory.create(:image, :viewable => @technique)
      @technique.image.should == image
    end

    it "should validate its description" do
      kata = @kata.techniques.build(@attributes).should be_valid
      kata = @kata.techniques.build(@attributes.merge(:description => 'x' * 81)).should_not be_valid
    end
  end
end
