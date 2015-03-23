class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:session][:username]
    user = Author.find_by(username: username)
    if user && user.password == params[:session][:password]
      session[:current_user] = user.id
      redirect_to  author_path(user)
    else
      render :new
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to  posts_path
  end
end
