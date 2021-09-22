# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :orders, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cnic, :address,:phone_no, presence: true
  # validates :phone_no, telephone_number:{ country: "pakistan", types: [:mobile]}

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "50x50!").processed
    else
      "/default_avatar.jpg"
    end
  end

  def order_in_cart
    orders.find_by(status: 0)
  end

  def placed_orders
    orders.where(status: 1).order(:created_at)
  end
end

