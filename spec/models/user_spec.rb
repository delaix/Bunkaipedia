require 'spec_helper'

describe User do
  before(:each) do
    @attributes = { :name => "Karate Do", :email => "karate@do.com", :password => "foobar",
      :password_confirmation => "foobar" }
  end

  it "should have a name" do
    User.new(@attributes).should respond_to(:name)
  end
  
  it "should accept a valid name" do
    User.new(@attributes).should be_valid
  end
  
  it "should not be valid when the name is not" do
    User.new(@attributes.merge(:name => 'x' * 65)).should_not be_valid
  end
end
