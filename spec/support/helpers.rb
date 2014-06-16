def sign_in(user)
  allow_any_instance_of(InvitesController).to receive(:current_user).and_return(user)
end
