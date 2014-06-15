require 'rails_helper'

describe Invite do
  describe 'defaults' do
    it "sets the organization info on create" do
      # TODO tie these two together
      invite = build(:invite)
      team = create(:team)
      expect(Team).to receive(:from_api).and_return(team)

      invite.save!

      expect(invite.organization_id).to eq(team.organization.id)
      expect(invite.organization_login).to eq(team.organization.login)
      expect(invite.team_name).to eq(team.name)
    end

    it "sets the key on create" do
      allow_any_instance_of(Invite).to receive(:update_info_if_team_changed)
      invite = create(:invite)

      key = invite.key
      expect(key).to be_a(String)
      expect(key.length).to eq(32)
    end
  end

  describe '#potential_teams_by_org' do
    let(:invite) { build(:invite) }

    it "omits the Owners teams" do
      team = create(:team, name: 'Owners')
      expect(invite.user).to receive(:invitable_teams).and_return([team])
      expect(invite.potential_teams_by_org).to eq(team.organization => [])
    end
  end
end
