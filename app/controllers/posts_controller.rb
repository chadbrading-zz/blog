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
    if params[:published]
      post = Post.new(posts_params.merge(author: Author.find(current_user), published: params[:published]))
    else
      post = Post.new(posts_params.merge(author: Author.find(current_user), publish_time: publish_time))
    end
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

  def publish_time
    ActiveSupport::TimeZone[publish_params['time_zone']].parse(publish_params['date']) + 60*60*hours(publish_params['hour'])
  end

  def publish_params
    params['publish_time']
  end

  def hours(time)
    hour = time.split(":")[0]
    if time.split(" ")[-1] == 'am'
      hour == '12' ? 0 : hour.to_i
    else
      hour == '12' ? 12 : hour.to_i + 12
    end
  end
end
