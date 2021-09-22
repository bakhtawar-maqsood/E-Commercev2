# frozen_string_literal: true

class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show edit update destroy index ]
  before_action :authenticate_user!, except: [:show]
  before_action :find_user, only: [:new, :index, :create]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = @user.products.build
  end

  def index
    if params[:search_term].nil?
      @products = @user.products
    else
      @products = @products.search_product(params[:search_term])
    end
  end

  def show
  end

  def edit
    authorize @product
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def create
    @product = @user.products.create(product_params)
    if @product.save
      ser_no = @product.generate_serial_number
      if @product.update(serial_no: ser_no)
        redirect_to product_path(@product)
      end
    else
      render 'new'
    end

  end

  def destroy
    authorize @product
    @user = @product.user
    redirect_to user_products_path(@user) if @product.destroy
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
