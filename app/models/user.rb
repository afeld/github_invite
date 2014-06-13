class User < ActiveRecord::Base
  has_many :invites

  def self.find_or_create_from_auth_hash(auth_hash)
    self.find_or_create_by(github_id: auth_hash['uid'])
  end
end
