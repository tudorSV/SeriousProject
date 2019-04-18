class Company < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :shops
  has_many :shop_slots, through: :shop
  has_many :employees

  validates :name, presence: true, length: { maximum: 20 },
                   uniqueness: true

  validates :email, presence: true,
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
