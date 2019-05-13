class Contact < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 20 }
  validates :message, presence: true, length: { maximum: 512 }

  validates :email, presence: true,
                    format: { with: EMAIL_REGEX }
end
