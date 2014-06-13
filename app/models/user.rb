class User < ActiveRecord::Base
  has_many :invites

  validates :github_id, presence: true
  validates :github_username, presence: true

  def self.find_or_create_from_auth_hash(auth_hash)
    self.find_or_create_by!(github_id: auth_hash['uid']) do |user|
      user.github_username = auth_hash['info']['nickname']
    end
  end
end
