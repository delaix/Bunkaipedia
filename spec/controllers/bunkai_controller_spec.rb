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
    
    it "should include maneuvers" do
      attack = @bunkai.maneuvers.create(:actor => "attacker", :description => "Punches to face.")
      defense = @bunkai.maneuvers.create(:actor => "defender",
        :description => "Blocks with a double block.")
      get :show, :id => @bunkai
      response.should have_selector("div.attacker", :content => attack.description)
      response.should have_selector("div.defender", :content => defense.description)
    end
  end
  
  describe "GET 'new'" do
    describe "while not signed" do
      it "should redirect to the sign-in page" do
        get :new
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in" do
      before(:each) do
        @kata = Factory(:kata)
        @user = Factory(:user)
        sign_in @user
      end
      
      it "should succede with a valid request" do
        get :new, :kata_id => @kata.id
        response.should be_success
      end
      
      it "should render the 'new' page" do
        get :new, :kata_id => @kata.id
        response.should render_template('new')
      end
    end
  end
  
  describe "POST 'create'" do
    describe "while not signed" do
      it "should redirect to the sign-in page" do
        get :new
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "while signed in" do
      before(:each) do
        @kata = Factory(:kata)
        @user = Factory(:user)
        sign_in @user
      end
      
      it "should render the edit page on success" do
        post :create, :bunkai => { :kata_id => @kata.id, :title => "test" }
        response.should render_template('edit')
      end
      
      it "should create a bunkai" do
        lambda do
          post :create, :bunkai => { :kata_id => @kata.id, :title => "test" }
        end.should change(Bunkai, :count).by(1)
      end
      
      it "should have the expected techniques" do
        technique_1 = @kata.techniques.create(:description => "first",
          :image => File.new("#{Rails.root}/spec/fixtures/images/test.png"))
        technique_2 = @kata.techniques.create(:description => "second",
          :image => File.new("#{Rails.root}/spec/fixtures/images/test.png"))
        post :create, :bunkai => { :kata_id => @kata.id, :title => "test" }, :technique_2 => technique_2.id,
          :technique_1 => technique_1.id
        Bunkai.last.techniques.should == [technique_2, technique_1]
      end
    end
  end
end
