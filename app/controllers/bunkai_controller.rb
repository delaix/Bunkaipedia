class BunkaiController < ApplicationController
  def show
    @bunkai = Bunkai.find(params[:id])
    @actions = @bunkai.actions
  end
end
