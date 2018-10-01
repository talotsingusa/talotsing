class ProductDesignType < ApplicationRecord
  belongs_to :product
  belongs_to :design_type
end
