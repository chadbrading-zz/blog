class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(posts_params)
      redirect_to author_path(post.author)
    else
      render :edit, id: params[:id]
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to author_path(post.author)
  end

  def new
    @post = Post.new
  end

  def create
    require 'pry'; binding.pry;
    post = PostPublishingService.new(params, posts_params, current_user)
    if post.save!
      redirect_to author_path(Author.find(current_user))
    else
      render :new
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content, :published)
  end
end
