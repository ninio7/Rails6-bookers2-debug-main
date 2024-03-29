class BooksController < ApplicationController



  def show
    @book = Book.find(params[:id])
    @user = current_user
    @newbook = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
     redirect_to  books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
           redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
   @book =  Book.find(params[:id])
   @book.destroy
   redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


   def correct_user
      @book = Book.find(params[:id])
    unless @book == current_user
      redirect_to user_path(current_user.id)
    end
   end
end

