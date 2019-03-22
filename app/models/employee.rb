class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :shop
  belongs_to :user

  scope :same_id,     ->(user){ where(user_id: user.id) }

  validates :user_id,  uniqueness: true
end
