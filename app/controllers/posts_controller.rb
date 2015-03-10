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
    post = Post.new(posts_params.merge(author: Author.find(current_user)))
    if post.save!
      redirect_to controller: 'authors', action: 'show', id: post.author.id
    else
      render :new
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content)
  end
end
