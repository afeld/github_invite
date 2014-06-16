FactoryGirl.define do
  factory :user do
    sequence :github_id
    sequence :github_username do |n|
      "testuser#{n}"
    end
  end

  factory :organization do
    skip_create

    sequence :id
    sequence :login do |n|
      "testorg#{n}"
    end
  end

  factory :team do
    skip_create

    sequence :id
    sequence :name do |n|
      "testteam#{n}"
    end
    organization

    factory :owners_team do
      name 'Owners'
    end
  end

  factory :invite do
    sequence :team_id
    user

    factory :populated_invite do
      team
    end
  end
end
