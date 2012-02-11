require 'spec_helper'

describe Comment do
  before(:each) do
    @attributes = { :text => "lorem ipsum" }
  end
  
  it "should have a user" do
    Comment.new(@attributes).should respond_to(:user)
  end
  
  it "should refer to a bunkai" do
    Comment.new(@attributes).should respond_to(:bunkai)
  end
  
  it "should have text" do
    Comment.new(@attributes).should respond_to(:text)
  end
  
  describe "content" do
    before(:each) do
      @user = Factory.create(:user)
      @kata = Factory.create(:kata)
      @bunkai = @user.bunkai.create(:kata_id => @kata, :title => "awufuwa")
      @attributes = @attributes.merge(:user_id => @user.id, :bunkai_id => @bunkai.id)
    end
    
    it "should refer to the right user" do
      Comment.new(@attributes).user.should == @user
    end
    
    it "should refer to the right bunkai" do
      Comment.new(@attributes).bunkai.should == @bunkai
    end
    
    it "should have the expected text" do
      Comment.new(@attributes).text.should == @attributes[:text]
    end
    
    it "should validate the text" do
      Comment.new(@attributes.merge(:text => nil)).should_not be_valid
    end
  end
end
