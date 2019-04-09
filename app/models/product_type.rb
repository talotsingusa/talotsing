class ProductType < ApplicationRecord
  belongs_to :sub_category, counter_cache: true
  has_many :product_groups, dependent: :destroy
  has_many :products , through: :product_groups, dependent: :destroy
  belongs_to :parent_product_type, class_name: 'ProductType', foreign_key: :parent_product_type_id, optional: true
  has_many :child_product_types, class_name: 'ProductType', foreign_key: :parent_product_type_id

  has_attached_file :image, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
