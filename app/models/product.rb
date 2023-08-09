class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :product_profile

  enum status: {available: "available", sold:"sold"}

end
