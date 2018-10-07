class ProductImage < ApplicationRecord
  belongs_to :product


  has_attached_file :image, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_attachment_content_type :image, content_type: /\Aimage/
  # Validate filename
  validates_attachment_file_name :image, matches: [/png\z/, /jpe?g\z/]
end
