class KatasController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :editor_user, :except => [:index, :show]


  def show
    @kata = Kata.find(params[:id])
    @techniques = @kata.techniques.order('id')
    @bunkai = @kata.bunkai.order('created_at DESC').paginate(
      :page => params[:page], :per_page => 20)
  end
  
  
  def new
    if params[:style_id]
      @kata = Style.find(params[:style_id]).katas.build()
    else
      render :back
    end
  end


  def create
    @kata = Kata.new(params[:kata])
    if @kata.save
      @techniques = @kata.techniques.order('id')
      @new_technique = Technique.new(:kata_id => @kata.id)
      render :edit
    else
      render :new
    end
  end
  
  
  def edit
    @kata = Kata.find(params[:id])
    @techniques = @kata.techniques.order('id')
    @new_technique = Technique.new(:kata_id => params[:id])
  end
  
  
private
  def editor_user
    unless current_user.editor?
      flash[:error] = "Permission denied"
      redirect_to(root_path)
    end
  end
end
