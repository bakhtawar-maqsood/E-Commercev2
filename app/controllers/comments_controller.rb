# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, except: :create
  before_action :find_product, only: %i[update destroy]
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    authorize @comment
    if @comment.save
      redirect_to product_path(@product), notice: "Comment added in #{@product.name}"
    else
      redirect_to product_path(@product), notice: 'Something went wrong'
    end
  end

  def edit
    authorize @comment
  end

  def update
    if @comment.update(comment_params)
      redirect_to @product, notice: 'comment updated successfully'
    else
      redirect_to @product, notice: 'Something went wrong in updating comment'
    end
  end

  def destroy
    authorize @comment
    if @comment.destroy
      respond_to do |format|
        format.js
        format.html { redirect_to @product, notice: 'Review Deleted Successfully' }
      end
    else
      redirect_to @product, notice: 'Something went wrong in deleting comment'
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_product
    @product = @comment.product
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, images: [])
  end
end
