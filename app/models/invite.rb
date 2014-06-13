class Invite < ActiveRecord::Base
  belongs_to :user

  validate :team_id, presence: true
  validate :user_id, presence: true

  def team
    @team ||= user.client.team(team_id)
  end

  def organization
    @organization ||= team.organization
  end
end
