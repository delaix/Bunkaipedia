class KatasController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]


  def index
    if params[:style_id]
      @style = Style.find(params[:style_id])
      @katas = @style.katas
    else
      @katas = Kata.all
    end
  end


  def show
    @kata = Kata.find(params[:id])
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
      render :edit
    else
      params[:style_id] = @kata.style_id
      render :new
    end
  end
  
  
  def edit
    @kata = Kata.find(params[:id])
    @new_technique = Technique.new(:kata_id => params[:id])
  end
end
