class Invite < ActiveRecord::Base
  extend FriendlyId
  friendly_id :key

  UPDATEABLE_ATTRS = %w(organization_id organization_login team_name)
  EXPIRATION = 3.days

  belongs_to :user

  validate :organization_id, presence: true
  validate :organization_login, presence: true
  validate :team_id, presence: true
  validate :team_name, presence: true
  validate :user_id, presence: true

  after_initialize :assign_key
  before_validation :update_attrs_if_needed

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

  def add_to_team(other_user)
    user.client.add_team_member(team_id, other_user.github_username)
  end

  def expires_at
    created_at + EXPIRATION
  end

  def expired?
    Time.now > expires_at
  end

  def redeem(other_user)
    !expired? && add_to_team(other_user)
  end

  def potential_orgs_with_teams
    results = user.invitable_teams.group_by{|team| team.organization }
    results.map{|org, teams|
      OrganizationWithTeams.new(id: org.id, login: org.login, teams: teams)
    }
  end


  protected

  def assign_key
    self.key ||= SecureRandom.hex(16)
  end

  def needs_update?
    team_id &&
      team_id_changed? &&
      # update from the API if the attributes weren't set/updated as well
      (UPDATEABLE_ATTRS.any?{|a| self.send(a).nil? } ||
        (UPDATEABLE_ATTRS - changed_attributes.keys).any?
      )
  end

  def update_from_api
    self.team = Team.from_api(team_id, user.client)
  end

  def update_attrs_if_needed
    if self.needs_update?
      self.update_from_api
    end
  end
end
