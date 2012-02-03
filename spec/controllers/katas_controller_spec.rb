require 'spec_helper'

describe KatasController do
  include Devise::TestHelpers

  describe "GET 'index'" do
    it "should succede" do
      get :index
      response.should be_success
    end
    
    it "should reder the index page" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @kata = Factory.create(:kata)
    end
    
    it "should succede" do
      get :show, :id => @kata
      response.should be_success
    end
    
    it "should reder the show page" do
      get :show, :id => @kata
      response.should render_template(:show)
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
        @user = Factory(:user)
        @style = Factory(:style)
        sign_in @user
      end
      
      it "should succede with a valid request" do
        get :new, :style_id => @style.id
        response.should be_success
      end
      
      it "should render the 'new' page" do
        get :new, :style_id => @style.id
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
        @user = Factory(:user)
        @style = Factory(:style)
        sign_in @user
      end
      
      it "should create a new kata" do
        lambda do
          kata = @style.katas.build(:name => "test")
          post :create, :kata => { :name => kata.name, :style_id => kata.style_id }
        end.should change(Kata, :count).by(1)
      end
      
      it "should render the edit page on success" do
        kata = @style.katas.build(:name => "test")
        post :create, :kata => { :name => kata.name, :style_id => kata.style_id }
        response.should render_template('edit')
      end
    end
  end
end
