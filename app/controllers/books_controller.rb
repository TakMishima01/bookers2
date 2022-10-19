class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    new
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new
  end

  def new
    @book_new = Book.new
  end

  def create
    index
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  def show
    new
    @book = Book.find(params[:id])
  end

  def edit
  end

  def update
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    user_id = @book.user_id.to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
end
