# frozen_string_literal: true

class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    @product = @user.wishlist&.products
  end

  def destroy
    if @user.wishlist.products.destroy(params[:product_id])
      redirect_to wishlist_path, notice: 'Deleted from Wishlist'
    else
      redirect_to wishlist_path, notice: 'Something went wrong'
    end
  end

  def create
    @wishlist = set_wishlist
    @product = Product.find(params[:wishlist][:product_id])
    authorize @product, :add?
    @wishlist.products << @product
    redirect_to wishlist_path, notice: 'Added to wishlist'
  end

  private

  def set_wishlist
    @wishlist = @user.wishlist || @user.create_wishlist(user_id: @user.id)
  end

  def find_user
    @user = current_user
  end

  def wishlist_params
    params.require(:wishlist).permit(:user_id)
  end
end
