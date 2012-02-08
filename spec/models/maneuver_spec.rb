require 'spec_helper'

describe Maneuver do
  before(:each) do
    @attributes = { :actor => "defender", :description => "Hits him." }
  end
  
  it "should belong to a bunkai" do
    Maneuver.new(@attributes).should respond_to(:bunkai)
  end
  
  it "should have a description" do
    Maneuver.new(@attributes).should respond_to(:description)
  end
  
  it "should specify and actor" do
    Maneuver.new(@attributes).should respond_to(:actor)
  end

  describe 'content' do
    before(:each) do
      @bunkai = Factory(:user).bunkai.create(:title => "whatever", :kata_id => 1)
    end
    
    it "should refer to the expected bunkai" do
      @bunkai.maneuvers.create(@attributes).bunkai.should == @bunkai
    end
    
    it "should accept an 'attacker' as an actor" do
      @bunkai.maneuvers.create(@attributes.merge(:actor => "attacker")).should be_valid
    end
    
    it "should accept a 'defender' as an actor" do
      @bunkai.maneuvers.create(@attributes.merge(:actor => "defender")).should be_valid
    end
    
    it "should be invalid with an invalid actor" do
      @bunkai.maneuvers.create(@attributes.merge(:actor => "INVALID")).should_not be_valid
    end
    
    it "should require some description" do 
      @bunkai.maneuvers.create(@attributes.merge(:description => "")).should_not be_valid
    end
  end
end
