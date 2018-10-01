class SleeveType < ApplicationRecord
  has_many :product_sleeve_types
  has_many :products , through: :product_sleeve_types
end
