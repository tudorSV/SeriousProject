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

  factory :appointment do
    sequence(:date) { '2019-04-20' }
    sequence(:item_number) { 5 }
    user
    shop
  end

  factory :employee do
    sequence(:role) { |n| "Employee #{n}" }
    user
    shop
    company
  end

  factory :shop do
    sequence(:name) { |n| "Shop #{n}" }
    sequence(:email) { |n| "Shop_#{n}@example.com" }
    address
    company
  end

  factory :shop_slot do
    sequence(:day) { |n| n % 7 }
    sequence(:max_appointments) { 10 }
    sequence(:open) { 'Mon, 08 Apr 2019 11:41:12 UTC +00:00' }
    sequence(:close) { 'Mon, 08 Apr 2019 18:41:12 UTC +00:00' }
    sequence(:closed) { true }
    shop
  end
end
