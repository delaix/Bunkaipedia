class UsersController < ApplicationController
  before_filter :authenticate_user!


  def show
    @user = User.find(params[:id])
    @bunkai = @user.bunkai.order('created_at DESC').paginate(
      :page => params[:page], :per_page => 10)
  end
end
