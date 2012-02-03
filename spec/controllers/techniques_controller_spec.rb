require 'spec_helper'

describe TechniquesController do
  include Devise::TestHelpers

  describe "POST 'create'" do
    describe "while not signed in" do
      it "should redirect to the sign-in page" do
        post :create
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in" do
      before(:each) do
        @kata = Factory(:kata)
        @user = Factory(:user)
        sign_in @user
        @attributes = { :description => "yo-oi", 
          :image => fixture_file_upload("/images/test.png", 'image/png'),
          :kata_id => @kata.id }
      end
      
      it "it should succede" do
        post :create, :technique => @attributes
        response.should be_success
      end
      
      it "it should create a technique" do
        lambda do
          post :create, :technique => @attributes
        end.should change(Technique, :count).by(1)       
      end
      
      it "it should render the kata edit page" do
        post :create, :technique => @attributes
        response.should render_template('katas/edit')
      end
    end
  end
  
  describe "PUT 'update'" do
    describe "while not signed in" do
      it "should redirect to the sign-in page" do
        put :update
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in" do
      before(:each) do
        kata = Factory(:kata)
        user = Factory(:user)
        @technique = kata.techniques.create(:description => "yo-oi",
          :image => File.new("#{Rails.root}/spec/fixtures/images/test.png"))
        sign_in user
        @attributes = { :description => "updated",
          :kata_id => kata.id }
      end
      
      it "should succeded" do
        put :update, :id => @technique, :technique => @attributes
        response.should be_success
      end
      
      it "should render the the kata edit page" do
        put :update, :id => @technique, :technique => @attributes
        response.should render_template('katas/edit')
      end
      
      it "should change the technique" do
        put :update, :id => @technique, :technique => @attributes
        @technique.reload.description.should == @attributes[:description]
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    describe "while not signed in" do
      it "should redirect to the sign-in page" do
        delete :destroy
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in" do
      before(:each) do
        kata = Factory(:kata)
        user = Factory(:user)
        @technique = kata.techniques.create(:description => "yo-oi",
          :image => File.new("#{Rails.root}/spec/fixtures/images/test.png"))
        sign_in user
      end
      
      it "should succede" do
        delete :destroy, :id => @technique
        response.should be_success
      end
      
      it "should delete the technique" do
        lambda do
          delete :destroy, :id => @technique
        end.should change(Technique, :count).by(-1)
      end
    end
  end
end
