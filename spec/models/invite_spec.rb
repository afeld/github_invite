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
      invite = create(:populated_invite)

      key = invite.key
      expect(key).to be_a(String)
      expect(key.length).to eq(32)
    end

    it "doesn't update the team info if it's all been provided" do
      expect_any_instance_of(Invite).to_not receive(:update_from_api)
      create(:populated_invite)
    end
  end

  describe '#redeem' do
    it "fails when the invite has expired" do
      invite = create(:populated_invite, created_at: 10.days.ago)
      user = create(:user)
      expect(invite.redeem(user)).to eq(false)
    end
  end

  describe '#redeem' do
    it "fails when the invite has expired" do
      invite = create(:populated_invite, created_at: 10.days.ago)
      user = create(:user)
      expect(invite.redeem(user)).to eq(false)
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
