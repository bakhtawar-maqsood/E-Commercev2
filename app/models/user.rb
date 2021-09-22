# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_one :wishlist, dependent: :destroy

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :cnic, :address, :phone_no, presence: true

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '50x50!').processed
    else
      '/default_avatar.jpg'
    end
  end

  def cart
    orders.find_by(status: 0)
  end

  def placed
    orders.where(status: 1).order(:created_at)
  end
end
