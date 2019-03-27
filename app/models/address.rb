class Address < ApplicationRecord
  has_one :shops, inverse_of: :address

  validates :short_address, presence: true, length: { maximum: 15 }
  validates :full_address, presence: true, length: { maximum: 25 }
  validates :city, presence: true, length: { maximum: 10 }
  validates :zipcode, presence: true,
                      length: { minimum: 5, maximum: 6 },
                      numericality: { only_integer: true }
  validates :country, presence: true
end
