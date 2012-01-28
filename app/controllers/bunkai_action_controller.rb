class BunkaiActionController < ApplicationController
  before_filter :authenticate_user!


  def create
  end
  
  
  def update
    @action = Action.find(params[:id])
    if current_user != @action.bunkai.user
      redirect_to bunkai_path(@action.bunkai)
    end
    puts params
    if @action.update_attributes(params[:action])
      flash[:success] = "Profile updated."
      redirect_to edit_bunkai_path(@action.bunkai)
    else
      #TODO: show error messages.
      redirect_to edit_bunkai_path(@action.bunkai)
    end
  end
  
  
  def destroy
  end
end
