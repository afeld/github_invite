Rails.application.config.middleware.use OmniAuth::Builder do
  key = ENV['GITHUB_KEY'] || raise("Please set GITHUB_KEY")
  secret = ENV['GITHUB_SECRET'] || raise("Please set GITHUB_SECRET")
  provider :github, key, secret, scope: 'admin:org'
end

if Rails.env.test?
  OmniAuth.config.test_mode = true
end
