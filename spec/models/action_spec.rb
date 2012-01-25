require 'spec_helper'

describe Action do
  before(:each) do
    @attributes = { :actor => "defender", :description => "Hits him." }
  end
  
  it "should accept an 'attacker' as an actor" do
    Action.new(@attributes.merge(:actor => "attacker")).should be_valid
  end
  
  it "should accept a 'defender' as an actor" do
    Action.new(@attributes.merge(:actor => "defender")).should be_valid
  end
  
  it "should be invalid with an invalid actor" do
    Action.new(@attributes.merge(:actor => "INVALID")).should_not be_valid
  end
  
  it "should require some description" do 
    Action.new(@attributes.merge(:description => "")).should_not be_valid
  end
end
