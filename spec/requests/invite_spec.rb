require 'rails_helper'

describe 'invites' do
  describe 'GET /:id' do
    let(:invite) { create_invite }

    def visit_invite
      get "/#{invite.key}"
    end

    it "forces the visitor to be logged in" do
      visit_invite
      expect(response).to redirect_to("/auth/github?origin=%2F#{invite.key}")
    end

    it "shows the page to the owner" do
      sign_in(invite.user)
      visit_invite
      expect(response.status).to eq(200)
    end

    context "visitor" do
      let(:visitor) { create(:user) }

      def stub_add
        stub_request(:put, "https://api.github.com/teams/#{invite.team_id}/members/#{visitor.github_username}")
      end

      before do
        sign_in(visitor)
      end

      it "adds them to the team" do
        stub_add.to_return(status: 204)
        visit_invite
        expect(response).to redirect_to("https://github.com/#{invite.organization_login}")
      end

      it "shows an error if unable to add them" do
        stub_add.to_return(status: 404)
        visit_invite
        expect(response.status).to eq(503)
      end
    end
  end
end
