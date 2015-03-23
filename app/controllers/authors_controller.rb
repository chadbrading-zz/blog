class AuthorsController < ApplicationController
  expose(:author)

  def new
  end

  def create
    author.password = params[:password]
    if author.save!
      session[:current_user] = author.id
      redirect_to author_path(author)
    else
      render :new
    end
  end

  def show
  end

  private

  def author_params
    params.require(:author).permit(:name, :username, :password)
  end
end
