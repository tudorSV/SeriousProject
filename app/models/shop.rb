class Shop < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  belongs_to :address, dependent: :delete
  belongs_to :company
  has_many :employees
  has_many :shop_slots

  accepts_nested_attributes_for :address

  validates :name, presence: true, length: { maximum: 20 }

  validates :email, presence: true,
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
