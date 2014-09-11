require 'rails_helper'

RSpec.describe Admin, :type => :model do
  describe "has_role?" do
    it "should has role editor" do
      admin = build(:editor)
      expect(admin.has_role?("editor")).to eq(true)
    end

    it "should not has role editor" do
      admin = build(:super_admin)
      expect(admin.has_role?("editor")).to be_falsey
    end
  end
end
