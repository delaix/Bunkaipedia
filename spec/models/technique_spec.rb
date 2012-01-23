require 'spec_helper'

describe Technique do
  before(:each) do
    @kata = Factory.create(:kata)
    @technique = @kata.techniques.create(:description => "front kick")
    @image = Factory(:image, :viewable => @technique)
  end
  
  it "should reference an image" do
    @technique.should respond_to(:image)
  end
  
  it "should have the correct image" do
    @technique.image.name.should == @image.name
  end
  
  it "should reference it's owner kata" do
    @technique.kata.should == @kata
  end
end
