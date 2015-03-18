class PublishPostWorker
  include Sidekiq::Worker

  def perform(post_id, tweet)
    post = Post.find(post_id)
    post.published = true
    TWITTER_CLIENT.update("http://localhost:3000/posts/#{post_id} #{tweet}")
    post.save!
  end
end
