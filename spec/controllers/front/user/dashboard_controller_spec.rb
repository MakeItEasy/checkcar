require 'rails_helper'

RSpec.describe Front::User::DashboardController, :type => :controller do
  describe "GET 'index'" do
    before(:each) do
      @user = create(:confirmed_user)
      sign_in :user, @user
    end

    it "should return http success" do
      get 'index'
      expect(response).to be_success
    end

    it "should return current_user's orders" do
      order1 = create(:order_net, user: @user)
      order3 = create(:order_net, user: @user)
      # 其他人的order
      order2 = create(:order_net)
      get 'index'
      expect(assigns(:orders)).to eq([order1, order3])
    end
  end

  describe "GET 'index' without signin" do
    it "should return no auth error" do
      get 'index'
      expect_redirect_to_user_sign_in
    end
  end
end
