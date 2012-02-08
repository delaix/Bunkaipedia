class BunkaiController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]


  def show
    @bunkai = Bunkai.find(params[:id])
    @techniques = @bunkai.techniques.order('id')
    @maneuvers = @bunkai.maneuvers.order('id')
  end

 
  def new
    if params[:kata_id]
      @kata = Kata.find(params[:kata_id])
      @techniques = @kata.techniques.order('id')
      @bunkai = @kata.bunkai.build()
    else
      redirect_to :back
    end
  end


  def create
    @bunkai = current_user.bunkai.build(params[:bunkai])
    technique_ids = []
    params.each do |key, value|
      case key
      when /technique.*/
        technique_ids << value.to_i
      end
    end
    if not technique_ids.empty?
      @bunkai.add_technique_ids *technique_ids
    end
    @kata = @bunkai.kata
    @maneuvers = @bunkai.maneuvers.order('id')
    if @bunkai.save
      @techniques = @bunkai.techniques.order('id')
      @new_maneuver = Maneuver.new()
      render :edit
    else
      @techniques = @kata.techniques.order('id')
      render :new
    end
  end


  def edit
    @bunkai = Bunkai.find(params[:id])
    redirect_to :show, @bunkai.id if @bunkai.user != current_user #TODO Show errors.
    @techniques = @bunkai.techniques.order('id')
    @maneuvers = @bunkai.maneuvers.order('id')
    @new_maneuver = Maneuver.new()
  end
end
