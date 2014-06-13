require 'rails_helper'

describe 'invites' do
  describe 'GET /:id' do
    let(:invite) { create_invite }

    def visit_invite
      get "/#{invite.id}"
    end

    it "forces the visitor to be logged in" do
      visit_invite
      expect(response).to redirect_to('/auth/github')
    end

    it "shows the page to the owner" do
      sign_in(invite.user)
      visit_invite
      expect(response.status).to eq(200)
    end

    it "adds the visitor to the team" do
      visitor = create(:user)
      sign_in(visitor)
      stub_request(:put, "https://api.github.com/teams/#{invite.team_id}/members/#{visitor.github_username}")

      visit_invite
      expect(response).to redirect_to("https://github.com/#{invite.organization_login}")
    end
  end
end
