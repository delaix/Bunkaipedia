require 'spec_helper'

describe PagesController do
  describe "GET 'home'" do
    it "should succede" do
      get :home
      response.should be_success
    end
  end
end
