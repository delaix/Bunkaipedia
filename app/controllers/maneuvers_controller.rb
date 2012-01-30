class ManeuversController < ApplicationController
  before_filter :authenticate_user!


  def create
    bunkai = Bunkai.find(params[:bunkai_id].to_i)
    return unless permitted_bunkai_user(bunkai)
    maneuver = bunkai.maneuvers.build(params[:maneuver])
    if maneuver.save
      flash[:success] = "Maneuver created." 
      render_bunkai_edit(bunkai)
    else
      bunkai.maneuvers.delete(maneuver)
      render_bunkai_edit(bunkai, maneuver)
    end
  end
  
  
  def update
    maneuver = Maneuver.find(params[:id])
    return unless permitted_bunkai_user(maneuver.bunkai)
    flash[:success] = "Maneuver updated." if maneuver.update_attributes(params[:maneuver])
    render_bunkai_edit(maneuver.bunkai)
  end
  
  
  def destroy
    maneuver = Maneuver.find(params[:id])
    bunkai = maneuver.bunkai
    return unless permitted_bunkai_user(maneuver.bunkai)
    maneuver.destroy
    flash[:success] = "Maneuver removed."
    render_bunkai_edit(bunkai)
  end


  private
    def permitted_bunkai_user(bunkai)
      if current_user == bunkai.user
        true
      else
        flash[:error] = "Permission denied."
        redirect_to bunkai_path(bunkai)
        false
      end
    end
    
    
    def render_bunkai_edit(bunkai, maneuver = Maneuver.new)
      @bunkai = bunkai
      @new_maneuver = maneuver
      render "bunkai/edit"
    end
end
