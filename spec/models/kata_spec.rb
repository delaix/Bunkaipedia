require 'spec_helper'

describe Kata do
  before(:each) do
    @kata = Kata.create(:name =>"Test Kata")
    @technique_1 = Factory(:technique, :kata => @kata)
    @technique_2 = Factory(:technique, :kata => @kata, :description => "reverse punch")
  end
  
  it "should have a name" do
    @kata.should respond_to(:name)
  end
  
  it "should respond to techniques" do
    @kata.should respond_to(:techniques)
  end
  
  it "should contain the expected techniques" do
    @kata.techniques.should == [@technique_1, @technique_2]
  end
end
