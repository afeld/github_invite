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

  def teams_by_org
    results = {}
    organizations.each do |org|
      results[org] = org.teams(client)
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
