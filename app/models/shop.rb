class Shop < ApplicationRecord
  belongs_to :address
  belongs_to :company

  accepts_nested_attributes_for :address
end
