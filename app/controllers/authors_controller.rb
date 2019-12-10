class AuthorsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      session[:user_id] = @author.id
      redirect_to '/posts'
      flash[:info] = "Welcome"
    else
      flash[:info] = 'Invalid Email or password'
      redirect_to '/registration'
    end
  end

  def confirm_email
    author = Author.find_by_confirm_token(params[:id])
    if author
      author.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to '/posts'
    end
  end

  private

  def author_params
    params.require(:author).permit(:email, :password, :first_name, :last_name)
  end
end
