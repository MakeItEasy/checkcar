require 'rails_helper'

RSpec.describe Front::StationsController, :type => :controller do

  describe "GET 'index'" do
    it "should returns http success" do
      stations = create_list(:station, 10, :reviewed)
      get 'index'
      expect(response).to be_success
      expect(assigns(:stations).to_a.count).to eq(stations.count)
      expect(assigns(:stations).to_a).to eq(stations)
    end

    it "should returns first page data" do
      per_page_count = Car::Constants::PER_COUNT_FOR_FRONT_STATIONS 
      stations = create_list(:station, per_page_count + 1, :reviewed)
      get 'index'
      expect(assigns(:stations).to_a.count).to eq(per_page_count)
      expect(assigns(:stations).to_a).to eq(stations[0..(per_page_count-1)])
    end

    it "should returns param page data" do
      per_page_count = Car::Constants::PER_COUNT_FOR_FRONT_STATIONS 
      stations = create_list(:station, per_page_count + 3, :reviewed)
      get 'index', page: 2
      expect(assigns(:stations).to_a.count).to eq(3)
      expect(assigns(:stations).collect{|item| item.id}).to eq(stations.last(3).collect{|item| item.id})
      expect(assigns(:stations).to_a).to eq(stations.last(3))

    end

    it "should return records which like given query name" do
      station1 = create(:station, :reviewed, name: "selected name")
      station2 = create(:station, :reviewed, name: "不被选中name")
      get :index, name: "lect"
      expect(assigns(:stations).to_a.count).to eq(1)
      expect(assigns(:stations).to_a).to eq([station1])
      expect(session[:station_conditions]['name']).to eq("lect")
    end

    it "should remove query key name" do
      station1 = create(:station, :reviewed, name: "selected name")
      station2 = create(:station, :reviewed, name: "不被选中name")
      get :index, name: "lect"
      get :index, unname: ""
      expect(assigns(:stations).to_a.count).to eq(2)
      expect(assigns(:stations).to_a).to eq([station1, station2])
      expect(session[:station_conditions]['name']).to be_nil
    end
  end

end
