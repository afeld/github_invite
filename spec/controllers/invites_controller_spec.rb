require 'rails_helper'

describe InvitesController do
  describe 'GET new' do
    it "redirects to auth" do
      get :new
      expect(response).to redirect_to('/auth/github')
    end

    it "displays the page when logged in" do
      user = User.create!(
        github_id: 123,
        github_username: 'testuser'
      )
      session[:user_id] = user.id

      get :new
      expect(response.status).to eq(200)
    end
  end
end
