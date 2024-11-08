class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_book, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  SORT_OPTIONS = %w[title author publication_year rating].freeze

  def index
    @sort = SORT_OPTIONS.include?(params[:sort]) ? params[:sort] : 'title'
    @books = Book.search(params[:search])
                 .sorted_by(@sort)
                 .page(params[:page])
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book successfully added!"
      redirect_to books_path
    else
      flash.now[:alert] = @book.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :publication_year, :isbn)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def handle_record_not_found
    flash[:alert] = "Book not found."
    redirect_to books_path
  end
end
