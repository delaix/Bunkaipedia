require 'spec_helper'

describe KatasController do
  include Devise::TestHelpers

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
    
    describe "while signed in as user" do
      before(:each) do
        sign_in Factory(:user)
      end
      
      it "should redirect to the kata page" do
        get :new
        response.should redirect_to(root_path)
      end
    end
    
    describe "while signed in as an editor" do
      before(:each) do
        @editor = Factory(:user)
        @editor.toggle!(:editor)
        @style = Factory(:style)
        sign_in @editor
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
        post :create
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in as user" do
      before(:each) do
        sign_in Factory(:user)
        @style = Factory(:style)
      end
      
      it "should redirect to the home page" do
        kata = @style.katas.build(:name => "test")
        post :create, :kata => { :name => kata.name, :style_id => @style.id }
        response.should redirect_to(root_path)
      end
    end

    describe "while signed in as an editor" do
      before(:each) do
        @editor = Factory(:user)
        @editor.toggle!(:editor)
        @style = Factory(:style)
        sign_in @editor
      end
      
      it "should create a new kata" do
        lambda do
          kata = @style.katas.build(:name => "test")
          post :create, :kata => { :name => kata.name, :style_id => @style.id }
        end.should change(Kata, :count).by(1)
      end
      
      it "should render the edit page on success" do
        kata = @style.katas.build(:name => "test")
        post :create, :kata => { :name => kata.name, :style_id => @style.id }
        response.should render_template('edit')
      end
    end
  end
 
  describe "GET 'edit'" do
    describe "while not signed" do
      it "should redirect to the sign-in page" do
        get :edit
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in as user" do
      before(:each) do
        sign_in Factory(:user)
      end
      
      it "should redirect to the home page" do
        get :edit
        response.should redirect_to(root_path)
      end
    end

    describe "while signed in as an editor" do
      before(:each) do
        @editor = Factory(:user)
        @editor.toggle!(:editor)
        @style = Factory(:style)
        @kata = @style.katas.create!(:name => "test")
        sign_in @editor
      end
      
      it "should succede" do
        get :edit, :id => @kata.id
        response.should be_success
      end
      
      it "should render the edit template" do
        get :edit, :id => @kata.id
        response.should render_template(:edit)
      end
    end
  end

  describe "POST 'update'" do
    describe "while not signed" do
      it "should redirect to the sign-in page" do
        post :update
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in as user" do
      before(:each) do
        sign_in Factory(:user)
        @style = Factory(:style)
        @kata = @style.katas.create(:name => "test")
      end
      
      it "should redirect to home page" do
        post :update, :id => @kata.id, :kata => { :name => 'modified' }
        response.should redirect_to(root_path)
      end
    end

    describe "while signed in as an editor" do
      before(:each) do
        @editor = Factory(:user)
        @editor.toggle!(:editor)
        @style = Factory(:style)
        @kata = @style.katas.create(:name => "test")
        sign_in @editor
      end
      
      it "should modify kata" do
        lambda do
          kata = @style.katas.build(:name => "test")
          post :update, :id => @kata.id, :kata => { :name => 'modified' }
          @kata.reload
        end.should change(@kata, :name)
      end
      
      it "should render the edit page on success" do
        post :update, :id => @kata.id, :kata => { :name => 'modified' }
        response.should render_template('edit')
      end
    end
  end
end
