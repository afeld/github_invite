require 'rails_helper'

describe 'invite' do
  describe 'creation' do
    it "displays an option to add teams to organizations the user owns" do
      user = create(:user)
      sign_in(user)

      team = create(:owners_team)
      expect_any_instance_of(User).to receive(:invitable_teams).and_return([team])

      visit '/invites/new'
      expect(page).to have_selector("[href=\"https://github.com/orgs/#{team.organization.slug}/new-team\"]")
    end

    it "doesn't display an option to add teams to organizations the user doesn't own" do
      user = create(:user)
      sign_in(user)

      team = create(:team)
      expect_any_instance_of(User).to receive(:invitable_teams).and_return([team])

      visit '/invites/new'
      expect(page).to_not have_selector("[href=\"https://github.com/orgs/#{team.organization.slug}/new-team\"]")
    end
  end
end
