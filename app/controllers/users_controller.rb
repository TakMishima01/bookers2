class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(current_user.id)
    @books = Book.all
  end

  def new
    @book_new = Book.new
  end

  def edit
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

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
