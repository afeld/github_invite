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

    factory :populated_invite do
      sequence :team_name do |n|
        "testteam#{n}"
      end
      sequence :organization_id
      sequence :organization_login do |n|
        "testorg#{n}"
      end
    end
  end
end
