class Organization
  include ActiveModel::Model

  attr_accessor :id, :login

  def teams(client)
    client.organization_teams(login).map do |team|
      Team.new(id: team.id, name: team.name, organization: self)
    end
  end

  def url
    "https://github.com/#{login}"
  end
end
