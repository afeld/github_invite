require 'rails_helper'

RSpec.describe "Invites", :type => :request do
  describe "GET /invites" do
    it "works! (now write some real specs)" do
      get invites_path
      expect(response.status).to be(200)
    end
  end
end
