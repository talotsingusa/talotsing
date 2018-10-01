class ProductSleeveType < ApplicationRecord
  belongs_to :product
  belongs_to :sleeve_type
end
