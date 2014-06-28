class FrontController < ApplicationController
  layout "front"
  before_action :set_catagory_nav

private
  def set_catagory_nav
    @catagories = Catagory.all
  end

end
