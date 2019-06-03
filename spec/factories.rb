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
    sequence(:date) { Time.zone.now + 5.years }
    sequence(:item_number) { |n| n % 5 }
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
    factory :shop_with_shop_slots do
      after(:create) do |shop|
        (0..6).map do |day|
          FactoryBot.create(:shop_slot, shop: shop, day: day)
        end
      end
    end
  end

  factory :shop_slot do
    sequence(:day) { |n| n % 7 }
    sequence(:max_appointments) { |n| (n % 48) + 2 }
    open_hour { DateTime.now + 1.hour }
    close_hour { DateTime.now + 8.hour }
    closed { false }
    shop
  end

  factory :contact do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:email) { |n| "Shop_#{n}@example.com" }
    sequence(:phone_number) { |n| n * 111_111_111 }
    sequence(:message) { |n| "Lorem #{n}" }
  end

  factory :note do
    user
    appointment
    sequence(:message) { |n| "Message number #{n}" }
  end
end
