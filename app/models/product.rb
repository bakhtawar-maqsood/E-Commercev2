# frozen_string_literal: true

class Product < ApplicationRecord
  include PgSearch::Model

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  has_and_belongs_to_many :wishlists

  has_many_attached :images

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 3 }
  validate :image_type_validation

  after_update :email_to_wisher

  pg_search_scope :search_product,
                  against: { name: 'A', price: 'B' },
                  using: {
                    tsearch: {
                      dictionary: 'english', tsvector_column: 'searchable'
                    }
                  }

  def generate_serial_number
    format('PK-%.6d', id)
  end

  def thumbnail(input)
    images[input].variant(resize: '200x200!').processed
  end

  def image_type_validation
    errors.add(:images, 'are missing') if images.attached? == false
    images.each do |image|
      errors.add(:images, 'needs to be a JPEG or PNG') unless image.content_type.in?(%(image/jpeg image/png))
    end
  end

  # def image_size_validation
  #   images.each do |image|
  #     errors.add(:images, 'should be less than 2MB') if image.size_range > 2.megabytes
  #   end
  # end

  def email_to_wisher
    return unless :price_changed?

    wishlist_data = wishlists.select(:user_id).pluck
    wishlist_data.each do |data|
      user_id = data[1]
      @user_email = User.select(:email).find(user_id)
      EcommerceMailer.price_changed(@user_email).deliver
    end
  end
end
