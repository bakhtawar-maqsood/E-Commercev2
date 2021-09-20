# frozen_string_literal: true

class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show edit update destroy index ]
  before_action :set_product
  before_action :authenticate_user!, except: [:show]
  before_action :set_scope, only: :index

  def new
    @user = User.find(params[:user_id])
    @product = @user.products.build
  end

  def index
    if params[:search_term].nil?
      @user = User.find(params[:user_id])
      @products = @user.products
    else
      @products = Product.search_product(params[:search_term])
    end
  end

  def search_param?
    unless params[:search].nil?
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def create
    @user = User.find(params[:user_id])
    @product = @user.products.create(product_params)
    if @product.save
      ser_no = @product.generate_serial_number
      if @product.update(serial_no: ser_no)
        redirect_to product_path(@product)
      else
        render 'new'
      end
    end

  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product
    @user = @product.user
    redirect_to user_products_path(@user) if @product.destroy
  end

  private

  def set_scope
    @product = Product.all
    if params[:search]
      name = search_name
      price = search_price
      product_ids = name | price
      @product = @product.find(product_ids)
    end
    @product
  end

  def search_name
    @product.where(
      "name ilike ? OR description ilike ?",
      "%#{params[:search]}%","%#{params[:search]}%"
    ).pluck(:id)
  end

  def search_price
    @product.where(
      "name ilike ?",
      "%#{params[:search]}%").pluck(:id)
  end


  def set_product
    # @user_id = current_user.id
  end

  def product_params
    params.require(:product).permit(:name, :serial_no, :price, :user_id, images: [])
  end
end
