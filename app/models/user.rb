# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cnic, :address, :phone_no, presence: true
  validates :phone_no, format: { with: /\d{4}-\d{7}/, message: 'use xxxx-xxxxxxx format' }
  validates :cnic, format: { with: /\d{5}-\d{7}-\d{1}/, message: 'use xxxxx-xxxxxxxx-x format' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '50x50!').processed
    else
      '/default_avatar.jpg'
    end
  end

  def order_in_cart
    orders.find_by(status: 0)
  end

  def placed_orders
    orders.where(status: 1).order(:created_at)
  end
end
