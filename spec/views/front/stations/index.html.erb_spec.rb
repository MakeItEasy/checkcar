require 'rails_helper'

RSpec.describe "front/stations/index.html.erb", :type => :view do
  context "with 2 stations" do
    before(:each) do
      @stations = create_list(:station, 2, :reviewed)
      assign(:stations, Station.page(1).per(10))
      session[:station_conditions] = {}
    end

    it "should display 2 stations" do
      render
      expect(rendered).to match /#{@stations[0].name}/
      expect(rendered).to match /#{@stations[1].name}/
    end
  end
end
