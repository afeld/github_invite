def sign_in(user)
  allow_any_instance_of(InvitesController).to receive(:current_user).and_return(user)
end

def create_invite
  invite = build(:populated_invite)
  # skip the auto-assignment
  expect(invite).to receive(:update_info_if_team_changed)
  invite.save!

  invite
end
