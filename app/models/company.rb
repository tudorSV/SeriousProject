class Company < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :shops do
    def by_id(shop)
      where(:id => shop.company_id)
    end
  end

  validates :name, presence: true, length: { maximum: 20 },
                   uniqueness: true

  validates :email, presence:true,
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
