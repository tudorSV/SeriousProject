class User < ApplicationRecord
  belongs_to :address
  has_one :employee, inverse_of: :user

  has_secure_password
  accepts_nested_attributes_for :address

  validates :name, presence: true, length: { maximum: 20 }
  validates :username, presence:true, length: { maximum:20 }
  validates :password, presence:true, length: { minimum:6 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true,
            format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
end
