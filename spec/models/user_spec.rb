require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "show name" do
    it "should be email" do
      user = build(:user_only_email)
      expect(user.show_name).to eq(user.email)
    end

    it "should be name" do
      user = build(:user_with_name_and_email)
      expect(user.show_name).to eq(user.name)
    end

    it "should be telephone" do
      user = build(:user_only_telephone)
      expect(user.show_name).to eq(user.telephone)
    end
  end
end
