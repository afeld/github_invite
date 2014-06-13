FactoryGirl.define do
  factory :user do
    sequence :github_id
    sequence :github_username do |n|
      "testuser#{n}"
    end
  end

  factory :invite do
    sequence :team_id
    user
  end
end
