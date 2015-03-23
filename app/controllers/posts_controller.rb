class PostsController < ApplicationController
  expose(:post, attributes: :post_params)
  expose(:posts)

  def update
    post_params
    if post.save
      redirect_to author_path(post.author)
    else
      render :edit, id: params[:id]
    end
  end

  def destroy
    post.destroy
    redirect_to author_path(post.author)
  end

  def create
    if publisher.save!
      redirect_to author_path(author)
   else
      render :new
    end
  end

  def show
    @html = RDiscount.new(post.markdown || "").to_html
  end

  private

  def author
    Author.find(current_user)
  end

  def new_post
    Post.new(post_params) do |p|
      p.author = author
    end
  end

  def publisher
    PostPublishingService.new(new_post, params)
  end

  def post_params
    params.require(:post).permit! #(:id, :title, :content, :published, :photo, :markdown)
  end
end
