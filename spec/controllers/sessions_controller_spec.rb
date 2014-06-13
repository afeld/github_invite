require 'rails_helper'

describe SessionsController do
  describe 'GET create' do
    before do
      request.env['omniauth.auth'] = {
        provider: 'github',
        uid: 123
      }
    end

    it "assigns the user" do
      get :create, provider: 'github'
      expect(controller.current_user).to be_a(User)
    end

    it "creates a new user" do
      get :create, provider: 'github'
      expect(User.count).to eq(1)
    end

    it "uses an existing user if their ID matches" do
      user = User.create(id: 123)
      get :create, provider: 'github'
      expect(User.count).to eq(1)
      expect(controller.current_user).to eq(user)
    end
  end
end
