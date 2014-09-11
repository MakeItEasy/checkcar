require 'rails_helper'

RSpec.describe Admin, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "has_role?" do
    it "should has role editor" do
      admin = build(:admin_with_role_editor)
      expect(admin.has_role?("editor")).to eq(true)
    end

    it "should not has role editor" do
      admin = build(:admin)
      expect(admin.has_role?("editor")).to eq(nil)
    end
  end
end
