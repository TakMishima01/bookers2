class UsersController < ApplicationController
  def index
    new
    @user = User.find(current_user.id)
    @users = User.all
  end

  def show
    index
    @user_show = User.find(params[:id])
    @books = @user_show.books
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
