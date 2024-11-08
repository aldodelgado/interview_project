class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: %i[edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def create
    @review = @book.reviews.build(review_params.merge(user: current_user))

    if @review.save
      flash[:notice] = "Review added successfully."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = @review.errors.full_messages.join(", ")
      @new_review = @review
      render 'books/show'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:notice] = "Review updated successfully!"
      redirect_to book_path(@book)
    else
      flash.now[:alert] = @review.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "Review deleted successfully!"
    redirect_to book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def authorize_user!
    unless @review.user == current_user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to book_path(@book)
    end
  end

  def handle_record_not_found
    flash[:alert] = "The record you're looking for does not exist."
    redirect_to books_path
  end
end
