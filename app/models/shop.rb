class Shop < ApplicationRecord
  belongs_to :address
  belongs_to :company
end
