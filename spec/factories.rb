FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Company #{n}" }
    sequence(:email) { |n| "Company_#{n}@example.com" }
  end

  factory :address do
    sequence(:short_address) { |n| "Short addr #{n}" }
    sequence(:full_address) { |n| "Long address #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:zipcode) { '00008' }
    sequence(:country) { |n| "Country #{n}" }
  end

  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:username) { |n| "Username#{n}" }
    sequence(:password) { |n| "passw#{n}" }
    sequence(:email) { |n| "User_#{n}@example.com" }
    address
  end

  factory :shop do
    sequence(:name) { |n| "Shop #{n}" }
    sequence(:email) { |n| "Shop_#{n}@example.com" }
    address
    company
  end
end
