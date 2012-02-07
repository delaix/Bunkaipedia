class PagesController < ApplicationController
  def home
    @styles = Style.order('name')
  end
end
