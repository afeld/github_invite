class Team
  include ActiveModel::Model

  attr_accessor :id, :name, :organization

  def self.from_api(team_id, client)
    team = client.team(team_id)
    org = Organization.new(id: team.organization.id, login: team.organization.login)
    Team.new(id: team.id, name: team.name, organization: org)
  end
end
