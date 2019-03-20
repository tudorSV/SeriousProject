class Company < ApplicationRecord
  has_many :shops

  validates :name, presence: true, length: { maximum: 20 },
                   uniqueness: true
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true,
            format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :active,  inclusion: { in: [ true, false ] }
end
