class StylesController < ApplicationController
  def index
    @styles = Style.all
  end
end
