require 'rails_helper'

describe 'Invites' do
  describe 'GET /' do
    it "redirects to auth" do
      get root_path
      expect(response.status).to redirect_to('/auth/github')
    end
  end
end
