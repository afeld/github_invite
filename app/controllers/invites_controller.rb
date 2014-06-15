class InvitesController < ApplicationController
  before_action :authenticate!

  def show
    @invite = Invite.find_by!(key: params[:id])
    if @invite.user == current_user
      # show the page
    else
      @invite.add_to_team(current_user)
      redirect_to @invite.organization.url
    end
  end

  def new
    @invite = Invite.new(user: current_user)
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.user = current_user

    if @invite.save
      redirect_to @invite, notice: 'Invite was successfully created.'
    else
      render :new
    end
  end


  private

  def invite_params
    params.require(:invite).permit(:team_id)
  end
end
