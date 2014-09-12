require 'rails_helper'

RSpec.describe FrontHelper, :type => :helper do
  describe "current_nav_class" do
    it "should return active when pass /" do
      controller.request.path = "/"
      c = helper.current_nav_class("/")
      expect(c).to eq('active')
    end

    it "should return nil when pass /" do
      controller.request.path = "/test"
      c = helper.current_nav_class("/")
      expect(c).to be_blank
    end

    it "should return active when start with" do
      controller.request.path = "/test/1"
      c = helper.current_nav_class("/test")
      expect(c).to eq('active')
    end

    it "should return nil when not start with" do
      controller.request.path = "/tesat/1"
      c = helper.current_nav_class("/test")
      expect(c).to be_blank
    end
  end

end
