require 'rails_helper'

RSpec.describe Front::WelcomeController, :type => :controller do
  describe "GET 'index'" do
    it "shoud returns http success" do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end
end
