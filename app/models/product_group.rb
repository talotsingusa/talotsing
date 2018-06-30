class ProductGroup < ApplicationRecord
  belongs_to :product_type
  belongs_to :product
end
