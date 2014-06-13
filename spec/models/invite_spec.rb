require 'rails_helper'

describe Invite do
  describe 'defaults' do
    it "sets the organization info on create" do
      invite = build(:invite)

      allow(invite).to receive_message_chain('organization.id').and_return(3)
      allow(invite).to receive_message_chain('organization.login').and_return('testorg')
      allow(invite).to receive_message_chain('team.name').and_return('testteam')

      invite.save!

      expect(invite.organization_id).to eq(3)
      expect(invite.organization_login).to eq('testorg')
      expect(invite.team_name).to eq('testteam')
    end
  end
end
