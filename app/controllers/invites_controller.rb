class InvitesController < ApplicationController
  before_action :authenticate!, except: [:show]
  before_action :set_invite, only: [:show]

  def show
  end

  def new
    @invite = Invite.new
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

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.require(:invite).permit(:team_id)
  end
end
