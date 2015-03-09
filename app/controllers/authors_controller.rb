class AuthorsController < ApplicationController
  def new
    @author = Author.new
  end

  def create
    author = Author.new(author_params)
    author.password = params[:password]
    if author.save!
      session[:current_user] = author.id
      redirect_to action: 'show', id: author.id
    else
      render :new
    end
  end

  def show
    @author = Author.find(params[:id])
  end

  private

  def author_params
    params.require(:author).permit(:name, :username, :password)
  end
end
