class BooksController < ApplicationController

  def index
    new
    @user = User.find(current_user.id)
    @books = Book.all
  end

  def new
    @book_new = Book.new
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      redirect_to book_path(book)
    else
      render :new
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  def show
    index
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
