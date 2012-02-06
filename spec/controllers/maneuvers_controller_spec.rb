require 'spec_helper'

describe ManeuversController do
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
        @bunkai = @user.bunkais.create!(:kata_id => @kata, :title => "test")
        @attributes = { :actor => "defender", :description => "duck!" }
      end
      
      describe "with bunkai creator" do
        before(:each) do
          sign_in @user
        end
        
        it "should succede" do
          post :create, :maneuver=> @attributes, :bunkai_id => @bunkai.id
          response.should be_success
        end
        
        it "should create a new maneuver" do
          lambda do
            post :create, :maneuver=> @attributes, :bunkai_id => @bunkai.id
          end.should change(Maneuver, :count).by(1)
        end
        
        it "should render the bunkai edit page" do
          post :create, :maneuver=> @attributes, :bunkai_id => @bunkai.id
          response.should render_template("bunkai/edit")
        end
        
        it "should validate the description" do
          lambda do
            post :create, :maneuver=> @attributes.merge(:description => nil), 
              :bunkai_id => @bunkai.id
          end.should_not change(Maneuver, :count)
        end
        
        it "should validate the actor presence" do
          lambda do
            post :create, :maneuver=> @attributes.merge(:actor => nil), 
              :bunkai_id => @bunkai.id
          end.should_not change(Maneuver, :count)
        end
        
        it "should validate the actor value" do
          lambda do
            post :create, :maneuver=> @attributes.merge(:actor => "invalid"), 
              :bunkai_id => @bunkai.id
          end.should_not change(Maneuver, :count)
        end
      end
      
      describe "with wrong user" do
        before(:each) do
          wrong_user = Factory(:user, :email => Factory.next(:email), :name => Factory.next(:name))
          sign_in wrong_user
        end
        
        it "should redirect to the bunkai page" do
          post :create, :maneuver=> @attributes, :bunkai_id => @bunkai.id
          response.should redirect_to(bunkai_path(@bunkai))
        end
        
        it "should not create a new maneuver" do
          lambda do
            post :create, :maneuver=> @attributes, :bunkai_id => @bunkai.id
          end.should_not change(Maneuver, :count)
        end
      end
    end
  end
  
  describe "PUT 'update'" do
    describe "while not signed in" do
      it "should redirect to the sign-in page" do
        post :update
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "while signed in" do
      before(:each) do
        @kata = Factory(:kata)
        @user = Factory(:user)
        @bunkai = @user.bunkais.create!(:kata_id => @kata, :title => "test")
        @attributes = { :actor => "defender", :description => "duck!" }
        @maneuver = @bunkai.maneuvers.create!(@attributes, :kata_id => @kata)
      end
      
      describe "with the bunkai owner" do
        before(:each) do
          sign_in @user
        end
        
        it "should succede" do
          put :update, :id => @maneuver.id, :maneuver=> { :description => "changed" }, 
            :bunkai_id => @bunkai.id
          response.should be_success
        end
        
        it "should render the bunkai edit page" do
          put :update, :id => @maneuver.id, :maneuver=> { :description => "changed" }, 
            :bunkai_id => @bunkai.id
          response.should render_template("bunkai/edit")
        end

        it "should change the maneuver attributes" do
          put :update, :id => @maneuver.id, :maneuver=> { :description => "changed" }, 
            :bunkai_id => @bunkai.id
          Maneuver.find(@maneuver.id).description.should =~ /changed/
        end
        
        it "should not change the description to an invalid value" do
          put :update, :id => @maneuver.id, :maneuver=> { :description => "" }, 
            :bunkai_id => @bunkai.id
          Maneuver.find(@maneuver.id).description.should == @attributes[:description]
        end
        
        it "should not change the actor to an invalid value" do
          put :update, :id => @maneuver.id, :maneuver=> { :actor => "invalid" }, 
            :bunkai_id => @bunkai.id
          Maneuver.find(@maneuver.id).actor.should == @attributes[:actor]
        end
      end
      
      describe "with the wrong user" do
        before(:each) do
          sign_in Factory(:user, :email => Factory.next(:email), :name => Factory.next(:name))
        end
        
        it "should redirect to the bunkai page" do
          put :update, :id => @maneuver.id, :maneuver=> { :description => "changed" }, 
            :bunkai_id => @bunkai.id
          response.should redirect_to(bunkai_path(@bunkai))
        end
        
        it "should not change the maneuver attributes" do
          put :update, :id => @maneuver.id, :maneuver=> { :description => "changed" }, 
            :bunkai_id => @bunkai.id
          Maneuver.find(@maneuver.id).description.should == @attributes[:description]
        end
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
    
    describe "while sigend in" do
      before(:each) do
        @kata = Factory(:kata)
        @user = Factory(:user)
        @bunkai = @user.bunkais.create!(:kata_id => @kata, :title => "test")
        @attributes = { :actor => "defender", :description => "duck!" }
        @maneuver = @bunkai.maneuvers.create!(@attributes, :kata_id => @kata)
      end
      
      describe "with the bunkai owner" do
        before(:each) do
          sign_in @user
        end
        
        it "should succede" do
          delete :destroy, :id => @maneuver
          response.should be_success
        end
        
        it "should delete the maneuver" do
          lambda do
            delete :destroy, :id => @maneuver
          end.should change(Maneuver, :count).by(-1)
        end
      end
      
      describe "with the wrong owner" do
        before(:each) do
          sign_in Factory(:user, :email => Factory.next(:email), :name => Factory.next(:name))
        end
        
        it "should redirect to the bunkai page" do
          delete :destroy, :id => @maneuver
          response.should redirect_to(bunkai_path(@bunkai))
        end
        
        it "should not delete the manuever" do
          lambda do
            delete :destroy, :id => @maneuver
          end.should_not change(Maneuver, :count)
        end
      end
    end
  end
end
