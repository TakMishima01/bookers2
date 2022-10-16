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

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      redirect_to book_path(book)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
