class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :shop
  belongs_to :user

  validates :user_id, uniqueness: true
  validates :role, presence: true
end
