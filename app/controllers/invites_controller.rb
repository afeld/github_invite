class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  # GET /invites
  def index
    @invites = Invite.all
  end

  # GET /invites/1
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites
  def create
    @invite = Invite.new(invite_params)

    if @invite.save
      redirect_to @invite, notice: 'Invite was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /invites/1
  def update
    if @invite.update(invite_params)
      redirect_to @invite, notice: 'Invite was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /invites/1
  def destroy
    @invite.destroy
    redirect_to invites_url, notice: 'Invite was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invite_params
      params.require(:invite).permit(:organization_id, :organization_name, :team_id, :team_name, :user_id)
    end
end
