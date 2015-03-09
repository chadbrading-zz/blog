class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:format])
  end

  def update
    post = Post.find(params[:format])
    if post.update(posts_params)
      redirect_to controller: 'authors', action: 'show', id: post.author.id
    else
      render :edit, format: params[:format]
    end
  end

  private

  def posts_params
    params.require(:post).permit(:content)
  end
end
