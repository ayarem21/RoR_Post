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


  private

  def author_params
    params.require(:author).permit(:email, :password)
  end
end
