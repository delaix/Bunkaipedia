class BunkaiController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]


  def show
    @bunkai = Bunkai.find(params[:id])
  end

 
  def new
    if params[:kata_id]
      @kata = Kata.find(params[:kata_id])
      @bunkai = @kata.bunkais.build()
    else
      redirect_to :back
    end
  end


  def create
    @bunkai = current_user.bunkais.build(params[:bunkai])
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
    if @bunkai.save
      @new_maneuver = Maneuver.new()
      render :edit
    else
      render :new
    end
  end


  def edit
    @bunkai = Bunkai.find(params[:id])
    redirect_to :show, @bunkai.id if @bunkai.user != current_user #TODO Show errors.
    @new_maneuver = Maneuver.new()
  end
end
