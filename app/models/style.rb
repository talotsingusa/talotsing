class Style < ApplicationRecord
  has_many :product_styles
  has_many :products , through: :product_styles
end
