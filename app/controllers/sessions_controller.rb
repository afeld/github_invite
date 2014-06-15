class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = user
    url = request.env['omniauth.origin'] || new_invite_url
    redirect_to(url)
  end


  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  # https://coderwall.com/p/bsfitw
  def current_user=(user)
    session[:user_id] = user.id
  end
end
