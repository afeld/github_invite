class Team
  include ActiveModel::Model

  attr_accessor :id, :name, :organization

  def self.from_sawyer(sawyer_team)
    team = Team.new(id: sawyer_team.id, name: sawyer_team.name)
    sawyer_org = sawyer_team.organization
    if sawyer_org
      team.organization = Organization.from_sawyer(sawyer_org)
    end
    team
  end

  def self.from_api(team_id, client)
    team = client.team(team_id)
    from_sawyer(team)
  end
end