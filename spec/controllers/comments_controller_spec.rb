require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers

  describe "POST 'create'" do
    before(:each) do
      @user = Factory(:user)
      @kata = Factory.create(:kata)
      @bunkai = @user.bunkai.create(:title => "a bunkai", :kata_id  => @kata)
      @attributes = { :bunkai_id => @bunkai.id, :user_id => @user.id, :text => "lorem ipsum" }
    end
    
    describe "while not signed in" do
      it "should redirect to the sign in page" do
        post 'create', :comment => @attributes
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in" do
      before(:each) do
        sign_in @user
      end
      
      it "should redirect back to the bunkai page" do
        post 'create', :comment => @attributes
        response.should redirect_to(bunkai_path(@bunkai))
      end
      
      it "should create a comment" do
        lambda do
          post 'create', :comment => @attributes
        end.should change(Comment, :count).by(1)
      end
      
      it "should render the bunkai page with bad input" do
        post 'create', :comment => @attributes.merge(:text => nil)
        response.should render_template('bunkai/show')
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = Factory(:user)
      @kata = Factory.create(:kata)
      @bunkai = @user.bunkai.create(:title => "a bunkai", :kata_id  => @kata)
      @attributes = { :bunkai_id => @bunkai.id, :user_id => @user.id, :text => "lorem ipsum" }
    end
    
    describe "while not signed in" do
      it "should redirect to the sign in page" do
        Comment.create!(:bunkai_id => @bunkai, :user_id => @user, :text => "lorem ipsum")
        put 'update', :comment => @attributes.merge(:text => "foo bar")
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "while signed in" do
      before(:each) do
        sign_in @user
        @comment = Comment.create!(@attributes)
      end
    
      it "should redirect to the bunkai page" do
        put 'update', :id => @comment.id, :comment => { :text => 'whatever' }
        response.should redirect_to(bunkai_path(@bunkai))
      end
    
      it "should modify the comment" do
        new_text = 'modified'
        put 'update', :id => @comment.id, :comment => { :text => new_text }
        @comment.reload.text.should == new_text
      end
      
      it "should render the edit page on failure" do
        put 'update', :id => @comment.id, :comment => { :text => nil }
        response.should render_template('comments/edit')
      end
    
      it "should not modify the comment" do
        new_text = 'modified'
        put 'update', :id => @comment.id, :comment => { :text => nil }
        @comment.reload.text.should == @attributes[:text]
      end
    end
    
    describe "while signed in as the wrong user" do
      before(:each) do
        @wrong_user = Factory.create(:user, :name => Factory.next(:name),
          :email => Factory.next(:email))
        sign_in @wrong_user
        @comment = Comment.create!(@attributes)
      end
    
      it "should redirect to the bunkai page" do
        put 'update', :id => @comment.id, :comment => { :text => 'whatever' }
        response.should redirect_to(bunkai_path(@bunkai))
      end
    
      it "should not modify the comment" do
        new_text = 'modified'
        put 'update', :id => @comment.id, :comment => { :text => new_text }
        @comment.reload.text.should_not == new_text
      end
    end
  end
end
