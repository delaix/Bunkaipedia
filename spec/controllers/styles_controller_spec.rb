require 'spec_helper'

describe StylesController do
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
      @style = Style.create(:name => "test")
    end
    
    it "should succede" do
      get :show, :id => @style
      response.should be_success
    end
    
    it "should render the show page" do
      get :show, :id => @style
      response.should render_template(:show)
    end
  end
end
