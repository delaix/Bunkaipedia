require 'spec_helper'

describe Image do
  before(:each) do
    @image = Factory(:image)
  end

  it "should have a name" do
    @image.should respond_to(:name)
  end
  
  it "should have a type" do
    @image.should respond_to(:extension)
  end
end
