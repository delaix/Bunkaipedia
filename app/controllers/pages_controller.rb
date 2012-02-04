class PagesController < ApplicationController
  def home
    @styles = Style.all
  end
end
