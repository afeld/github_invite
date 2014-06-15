require 'rails_helper'

describe User do
  describe '#invitable_teams' do
    let(:user) { create(:user) }

    it "includes all teams from orgs that the user owns" do
      owners = create(:team, name: 'Owners')
      expect(user).to receive(:teams).and_return([owners])

      other = create(:team)
      expect(owners.organization).to receive(:teams).and_return([other, owners])

      teams = user.invitable_teams
      expect(teams.map(&:name)).to eq([other.name, 'Owners'])
    end
  end

  describe '.find_or_create_from_auth_hash' do
    it "updates the github_username" do
      user1 = create(:user, github_id: 123)
      user2 = User.find_or_create_from_auth_hash(auth_hash)
      expect(user2).to eq(user1)
      # check that it was saved
      expect(user2).to_not be_changed
      expect(user2.github_username).to eq('testuser')
    end
  end
end
