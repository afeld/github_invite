require 'rails_helper'

describe User do
  describe '.find_or_create_from_auth_hash' do
    it "updates the github_username" do
      user1 = User.create!(github_id: 123, github_username: 'olduser')
      user2 = User.find_or_create_from_auth_hash(auth_hash)
      expect(user2).to eq(user1)
      # check that it was saved
      expect(user2).to_not be_changed
      expect(user2.github_username).to eq('testuser')
    end
  end
end
