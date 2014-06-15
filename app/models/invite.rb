class Invite < ActiveRecord::Base
  extend FriendlyId
  friendly_id :key

  belongs_to :user

  validate :organization_id, presence: true
  validate :organization_login, presence: true
  validate :team_id, presence: true
  validate :team_name, presence: true
  validate :user_id, presence: true

  after_initialize :assign_key
  before_validation :update_info_if_team_changed

  def team
    Team.new(id: team_id, name: team_name, organization: organization)
  end

  def team=(team_class)
    self.organization_id = team_class.organization.id
    self.organization_login = team_class.organization.login
    self.team_id = team_class.id
    self.team_name = team_class.name
  end

  def organization
    Organization.new(id: organization_id, login: organization_login)
  end

  def add_to_team(other)
    user.client.add_team_member(team_id, other.github_username)
  end

  def potential_teams
    teams = user.invitable_teams
    teams.reject{|team| team.name == 'Owners' }
  end

  def potential_teams_by_org_login
    potential_teams.group_by{|team| team.organization.login }
  end

  def sorted_potential_teams_by_org_login
    results = potential_teams_by_org_login
    results.each do |org_login, teams|
      teams.sort_by!(&:slug)
    end
    results.sort_by{|org_login, teams| org_login.downcase }
  end


  protected

  def assign_key
    self.key ||= SecureRandom.hex(16)
  end

  def update_info_if_team_changed
    if team_id && team_id_changed?
      self.team = Team.from_api(team_id, user.client)
    end
  end
end
