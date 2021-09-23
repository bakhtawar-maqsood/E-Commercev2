# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many_attached :images

  validates :body, presence: true
  validate :image_type_validation

  def thumbnail(input)
    images[input].variant(resize: '100x100!').processed
  end

  def image_type_validation
    images.each do |image|
      errors.add(:images, 'needs to be a JPEG or PNG') unless image.content_type.in?(%(image/jpeg image/png))
    end
  end
end
