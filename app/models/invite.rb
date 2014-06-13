class Invite < ActiveRecord::Base
  belongs_to :user

  validate :team_id, presence: true
  validate :user_id, presence: true

  before_validation :update_info_if_team_changed

  def team
    @team ||= user.client.team(team_id)
  end

  def organization
    @organization ||= team.organization
  end

  def add_to_team(other)
    user.client.add_team_member(team_id, other.github_username)
  end

  def organization_url
    "https://github.com/#{organization_login}"
  end


  protected

  def update_info_if_team_changed
    if team_id && team_id_changed?
      self.organization_id = organization.id
      self.organization_login = organization.login
      self.team_name = team.name
    end
  end
end
