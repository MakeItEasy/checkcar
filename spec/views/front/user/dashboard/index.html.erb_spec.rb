require 'rails_helper'

RSpec.describe "front/user/dashboard/index.html.erb", :type => :view do
  it "should render user`s orders" do
    user = create(:user_who_has_orders)
    assign(:orders, user.orders)
    render
    expect(rendered).to match /#{user.orders[0].order_no}/
    expect(rendered).to match /#{user.orders[1].order_no}/
    expect(rendered).to match /#{user.orders[2].order_no}/
  end
end
