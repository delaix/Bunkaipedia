require 'spec_helper'

describe BunkaiController do
  render_views
  include Devise::TestHelpers

  describe "GET 'show'" do
    before(:each) do
      @user = Factory.create(:user)
      @kata = Factory.create(:kata)
      @bunkai = @user.bunkais.create(:title => "a bunkai", :kata_id  => @kata)
    end
    
    it "should succede" do
      get :show, :id => @bunkai
      response.should be_success
    end
    
    it "should show a bunkai" do
      get :show, :id => @bunkai
      response.should have_selector("span", :id => "bunkai")
    end
    
    it "should include actions" do
      attack = @bunkai.actions.create(:actor => "attacker", :description => "Punches to face.")
      defense = @bunkai.actions.create(:actor => "defender",
        :description => "Blocks with a double block.")
      get :show, :id => @bunkai
      response.should have_selector("div.attacker", :content => attack.description)
      response.should have_selector("div.defender", :content => defense.description)
    end
  end
end
