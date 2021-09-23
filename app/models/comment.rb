# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many_attached :images

  validates :body, presence: true

  def thumbnail(input)
    images[input].variant(resize: '100x100!').processed
  end
end
