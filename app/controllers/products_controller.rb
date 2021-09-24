# frozen_string_literal: true

class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show edit update destroy index ]
  before_action :authenticate_user!, except: [:show]
  before_action :find_user, only: %i[new index create]
  before_action :find_product, only: %i[show edit update destroy]

  def new
    @product = @user.products.build
  end

  def index
    @products = if params[:search_term].nil?
                  @user.products
                else
                  @products.search_product(params[:search_term])
                end
  end

  def show; end

  def edit
    authorize @product
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product Updated'
    else
      render 'edit'
    end
  end

  def create
    @product = @user.products.create(product_params)
    if @product.save
      ser_no = @product.generate_serial_number
      redirect_to product_path(@product), notice: 'Product Created' if @product.update(serial_no: ser_no)
    else
      render 'new', notice: 'Cant create product'
    end
  end

  def destroy
    authorize @product
    @user = @product.user
    if @product.destroy
      redirect_to user_products_path(@user), notice: 'Product Deleted'
    else
      redirect_to user_products_path(@user), notice: 'Something went Wrong'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :user_id, images: [])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
