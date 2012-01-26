require 'spec_helper'

describe Bunkai do
  before(:each) do
    @user = Factory(:user)
    @kata = Factory(:kata)
    @attributes = {:title => "some fancy move" }
  end
  
  it "should refer to the correct kata" do
    bunkai = @user.bunkais.create(@attributes)
    bunkai.create_kata_association(:kata_id => @kata)
    bunkai.kata.should == @kata
  end
end
