require 'spec_helper'

describe Bunkai do
  before(:each) do
    @user = Factory(:user)
    @kata = Factory(:kata)
    @attributes = {:title => "some fancy move" }
  end
  
  it "should refer to the proper user" do
    @user.bunkais.create(@attributes).user.should == @user
  end
  
  it "should refer to the correct kata" do
    bunkai = @user.bunkais.create(@attributes)
    bunkai.create_kata_association(:kata_id => @kata)
    bunkai.kata.should == @kata
  end
  
  it "should have the expected actions" do
    bunkai = @user.bunkais.create(@attributes)
    action_1 = bunkai.actions.create(:actor => "attacker", :description => "punch to face")
    action_2 = bunkai.actions.create(:actor => "defender", :description => "kick to groin") 
    bunkai.actions.should == [action_1, action_2]
  end
  
  it "should have the expected techniques" do
    bunkai = @user.bunkais.create(@attributes)
    technique_1 = Factory(:technique)
    technique_2 = Factory(:technique)
    bunkai.technique_associations.create(:technique_id => technique_1.id)
    bunkai.technique_associations.create(:technique_id => technique_2.id)
    bunkai.techniques.should == [technique_1, technique_2]
  end
end
