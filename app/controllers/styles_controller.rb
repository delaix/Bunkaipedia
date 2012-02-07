class StylesController < ApplicationController
  def index
    @styles = Style.order('name')
  end
  
  def show
    @style = Style.find(params[:id])
  end
end
