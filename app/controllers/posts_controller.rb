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
    if publisher.save!
      redirect_to author_path(author)
   else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @html = RDiscount.new(@post.markdown || "").to_html
  end

  private

  def author
    Author.find(current_user)
  end

  def post
    Post.new(posts_params) do |p|
      p.author = author
    end
  end

  def publisher
    PostPublishingService.new(post, params)
  end

  def posts_params
    params.require(:post).permit(:title, :content, :published, :photo, :markdown)
  end
end
