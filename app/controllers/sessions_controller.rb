class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:session][:username]
    user = Author.find_by(username: username)
    if user.password == params[:session][:password]
      session[:current_user] = user.id
      redirect_to controller: 'authors', action: 'show', id: user.id
    else
      render :new
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to controller: 'posts', action: 'index'
  end
end
