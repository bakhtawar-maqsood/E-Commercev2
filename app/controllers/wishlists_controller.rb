# frozen_string_literal: true

class WishlistsController < ApplicationController
  before_action :set_user, only: [:create, :show, :destroy]

  def show
    @product = @user.wishlist&.products
  end

  def destroy
    @product = @user.wishlist.products.destroy(params[:product_id])
    redirect_to user_wishlist_path(@user)
  end

  def edit; end

  def update; end

  def create
    @wishlist = set_wishlist
    @product = Product.find(params[:wishlist][:product_id])
    authorize @product, :add?
    @add = @wishlist.products << @product
    redirect_to user_wishlist_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_wishlist
    @wishlist = @user.wishlist || @user.create_wishlist(user_id: @user.id)
  end

  def wishlist_params
    params.require(:wishlist).permit(:user_id)
  end
end
