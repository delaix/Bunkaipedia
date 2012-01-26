require 'spec_helper'

describe Bunkai do
  before(:each) do
    @attributes = { :title => "some fancy move" }
  end
  
  it "should refer to a kata" do
    Bunkai.new(@attributes).should respond_to(:kata)
  end
  
  it "should refer to techniques" do
    Bunkai.new(@attributes).should respond_to(:techniques)
  end
  
  it "should have actions" do
    Bunkai.new(@attributes).should respond_to(:actions)
  end
  
  it "should belong to a user" do
    Bunkai.new(@attributes).should respond_to(:user)
  end
  
  describe "content" do
    before(:each) do
      @user = Factory(:user)
      @kata = Factory(:kata)
      @attributes = @attributes.merge(:kata_id => @kata)
    end
    
    it "should refer to the proper user" do
      @user.bunkais.create(@attributes).user.should == @user
    end
    
    it "should refer to the correct kata" do
      bunkai = @user.bunkais.build(@attributes)
      bunkai.kata.should == @kata
    end
    
    it "should have the expected actions" do
      bunkai = @user.bunkais.create(@attributes)
      action_1 = bunkai.actions.create(:actor => "attacker", :description => "punch to the face")
      action_2 = bunkai.actions.create(:actor => "defender", :description => "kick to the groin") 
      bunkai.actions.should == [action_1, action_2]
    end
    
    it "should have the expected techniques" do
      bunkai = @user.bunkais.create(@attributes)
      technique_1 = Factory(:technique)
      technique_2 = Factory(:technique)
      bunkai.techniques << technique_1
      bunkai.techniques << technique_2
      bunkai.techniques.should == [technique_1, technique_2]
    end
    
    it "should validate its title" do
      @user.bunkais.build( @attributes).should be_valid
      @user.bunkais.create(@attributes.merge(:title => 'x' * 81)).should_not be_valid
    end
  end
end
