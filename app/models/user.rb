class User < ApplicationRecord
  belongs_to :address
  has_one :employee, inverse_of: :user

  has_secure_password
  accepts_nested_attributes_for :address
end
