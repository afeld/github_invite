require 'rails_helper'

describe SessionsController do
  describe 'GET create' do
    before do
      request.env['omniauth.auth'] = {
        'provider' => 'github',
        'uid' => 123,
        'info' => {
          'nickname' => 'testuser'
        }
      }
    end

    it "creates a new user" do
      get :create, provider: 'github'

      user = controller.current_user
      expect(user).to_not be_nil
      expect(user.github_id).to eq(123)
      expect(user.github_username).to eq('testuser')
    end

    it "uses an existing user if their ID matches" do
      user = User.create!(
        github_id: 123,
        github_username: 'testuser'
      )
      get :create, provider: 'github'
      expect(User.count).to eq(1)
      expect(controller.current_user).to eq(user)
    end
  end
end
