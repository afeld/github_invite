require 'rails_helper'

describe User do
  describe '.find_or_create_from_auth_hash' do
    it "updates the github_username" do
      user1 = User.create!(github_id: 123, github_username: 'Old')
      user2 = User.find_or_create_from_auth_hash(
        'provider' => 'github',
        'uid' => 123,
        'info' => {
          'nickname' => 'testuser'
        }
      )
      expect(user2).to eq(user1)
      expect(user2).to_not be_changed
    end
  end
end
