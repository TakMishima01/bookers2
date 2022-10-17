class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]


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
    new
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(book)
    else
      render :index
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
end
