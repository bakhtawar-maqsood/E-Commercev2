# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, except: :create
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    authorize @comment
    if @comment.save
      redirect_to product_path(@product)
    else

    end
  end

  def edit
    authorize @comment
  end

  def update
     return unless @comment.update(comment_params)
      @product = @comment.product
      redirect_to @product
  end

  def destroy
    authorize @comment
    @product = @comment.product
    @comment.destroy
    respond_to do |format|
      format.js
      format.html {redirect_to @product, notice: "Review Deleted Successfully"}
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, images: [])
  end

end
