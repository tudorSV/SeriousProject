class Shop < ApplicationRecord
  belongs_to :address
  belongs_to :company

  accepts_nested_attributes_for :address

  validates :name, presence: true, length: { maximum: 20 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
