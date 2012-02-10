require 'spec_helper'

describe UsersController do
  render_views
  
  include Devise::TestHelpers

  describe "GET 'show'" do
    before(:each) do
      @user = Factory.create(:user)
    end
    
    describe "while not signed in" do
      it "should redirect to the sign in page" do
        get :show, :id => @user
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in" do
      before(:each) do
        sign_in @user
      end
      
      it "should succede" do
        get :show, :id => @user
        response.should be_success
      end
      
      it "should reder the show page" do
        get :show, :id => @user
        response.should render_template(:show)
      end
      
      it "should show the user's email" do
        get :show, :id => @user
        response.should have_selector("span#email")
      end
    end
    
    describe "while not signed in" do
      before(:each) do
        other_user = Factory.create(:user, :email => Factory.next(:email),
          :name => Factory.next(:name))
        sign_in other_user
      end
      
      it "should not show the user's email" do
        get :show, :id => @user
        response.should_not have_selector("span#email")
      end
    end
  end
end
