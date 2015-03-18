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
    post = PostPublishingService.new(params, posts_params, current_user, params[:tweet])
    if post.save!
      post_id = Post.last.id
      TWITTER_CLIENT.update("http://localhost:3000/posts/#{post_id} #{params[:tweet]}")
      redirect_to author_path(Author.find(current_user))
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post.markdown
      @html = RDiscount.new(@post.markdown).to_html
    end
  end

  private

  def posts_params
    params.require(:post).permit(:title, :content, :published, :photo, :markdown)
  end
end
