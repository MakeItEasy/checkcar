class FrontController < ApplicationController
  layout "front"
  before_action :set_catagory_nav

  # GET /sign_in_status.json
  # 得到当前是否登录，适用于AJAX请求
  def sign_in_status
    if current_user
      render text: 'true', status: :ok
    else
      render text: 'false', status: :ok
    end
  end

private
  def set_catagory_nav
    @catagories = Catagory.all
  end
end
