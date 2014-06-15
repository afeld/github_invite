class User < ActiveRecord::Base
  has_many :invites, dependent: :destroy

  validates :github_id, presence: true
  validates :github_username, presence: true


  def client
    @client ||= Octokit::Client.new(access_token: self.token)
  end

  def organizations
    @organizations ||= client.organizations.map{|org| Organization.from_sawyer(org) }
  end

  def teams
    @teams ||= client.user_teams.map{|team| Team.from_sawyer(team) }
  end

  def invitable_teams
    results = []
    teams.each do |team|
      if team.name == 'Owners'
        # include all teams from that organization
        additional_teams = team.organization.teams(client)
        results.concat(additional_teams)
      else
        results << team
      end
    end
    results
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    user = self.find_or_initialize_by(github_id: auth_hash['uid'])
    # set/update fields
    user.github_username = auth_hash['info']['nickname']
    user.token = auth_hash['credentials']['token']
    user.save!

    user
  end
end
