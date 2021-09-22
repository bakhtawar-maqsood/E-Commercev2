class WishlistsController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    if @user.wishlist != nil
      @product = @user.wishlist.products
    else
      @product = nil
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @product = @user.wishlist.products.destroy(params[:product_id])
    redirect_to user_wishlist_path(@user)
  end

  def create
    @user = User.find(params[:user_id])
    @wishlist = set_wishlist
    @product = Product.find(params[:wishlist][:product_id])
    authorize @product, :add?
    @add = @wishlist.products << @product

    redirect_to user_wishlist_path(@user)
  end

  private

  def set_wishlist
    # @user = User.find(params[:user_id])
    @wishlist = @user.wishlist || @user.create_wishlist(user_id: @user.id)
  end

  def wishlist_params
    params.require(:wishlist).permit(:user_id)
  end
end

