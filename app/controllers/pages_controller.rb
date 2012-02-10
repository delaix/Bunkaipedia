class PagesController < ApplicationController
  def home
    @styles = Style.order('name')
    @bunkai = Bunkai.order('created_at DESC')[0..3]
  end
end
