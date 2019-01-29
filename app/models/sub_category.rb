class SubCategory < ApplicationRecord
  has_many :product_types, dependent: :destroy
  belongs_to :category
  has_many :product_sub_categories, dependent: :destroy
  has_many :products , through: :product_sub_categories
  belongs_to :parent_subcategory, class_name: 'SubCategory', foreign_key: :parent_sub_category_id, optional: true
  has_many :child_subcategories, class_name: 'SubCategory', foreign_key: :parent_sub_category_id

  has_attached_file :image, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
