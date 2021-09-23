# frozen_string_literal: true

class CommentsController < ApplicationController
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
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
     return unless @comment.update(comment_params)
      @product = @comment.product
      redirect_to @product
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @product = @comment.product
    @comment.destroy
    respond_to do |format|
      format.js
      format.html {redirect_to @product, notice: "Review Deleted Successfully"}
      format.json {head :no_content}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, images: [])
  end

end
