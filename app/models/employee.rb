class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :shop
  belongs_to :user

end
