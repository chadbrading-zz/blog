class PublishPostWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)
    post.published = true
    post.save!
  end
end
