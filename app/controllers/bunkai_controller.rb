class BunkaiController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]


  def show
    @bunkai = Bunkai.find(params[:id])
  end

 
  def new
    if params[:kata_id]
      @bunkai = Bunkai.new
      @kata = Kata.find(params[:kata_id])
    else
      redirect_to :back
    end
  end


  def create
    kata_id = params[:kata_id].to_i
    @kata = Kata.find(kata_id)
    @bunkai = current_user.bunkais.create!(
      :title => params[:title], :kata_id => kata_id)
    technique_ids = []
    params.each do |key, value|
      case key
      when /technique.*/
        technique_ids << value.to_i
      end
    end
    if not technique_ids.empty?
      @bunkai.add_technique_ids technique_ids
    end
    @new_maneuver = Maneuver.new()
    render :edit
  end


  def edit
    @bunkai = Bunkai.find(params[:id])
    redirect_to :show, @bunkai.id if @bunkai.user != current_user #TODO Show errors.
    @new_maneuver = Maneuver.new()
  end
end
