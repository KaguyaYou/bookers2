class BooksController < ApplicationController

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books=Book.all
      render "index"
    end
  end

  def show
    @user=current_user
    @book=Book.find(params[:id])
    @book_new =Book.new
  end

  def index
    @user =current_user
    @books=Book.all
    @book=Book.new
  end

  def edit
    @book =Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have creatad book successfully."
      redirect_to  book_path(@book.id)
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to "/books"
  end

	private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def  ensure_current_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end
end
