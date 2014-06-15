class Organization
  include Octoclass

  attr_accessor :id, :login

  def teams(client)
    client.organization_teams(login).map do |obj|
      team = Team.from_sawyer(obj)
      team.organization = self
      team
    end
  end

  def url
    "https://github.com/#{login}"
  end

  def self.from_sawyer(org)
    Organization.new(id: org.id, login: org.login)
  end
end
