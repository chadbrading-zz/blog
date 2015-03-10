class PostPublishingService

  attr_reader :params, :posts_params, :user
  def initialize(params, posts_params, user)
    @params = params
    @user = user
    @posts_params = posts_params
  end

  def save!
    if published
      post = Post.new(posts_params.merge(author: Author.find(user), published: published))
    else
      post = Post.new(posts_params.merge(author: Author.find(user), publish_time: publish_time))
    end
    post.save!
    PublishPostWorker.perform_at(post['publish_time'], post.id) unless published
    true
  end

  def publish_time
    published || ActiveSupport::TimeZone[time_zone].parse(date) + seconds
  end

  private

  def published
    params['published']
  end

  def date
    publish_params['date']
  end

  def time_zone
    publish_params['time_zone']
  end

  def publish_params
    params['publish_time']
  end

  def time
    publish_params["hour"]
  end

  def seconds
    60 * 60 * hours
  end

  def am?
    time.split(" ")[-1] == 'am'
  end

  def hour
    time.split(":")[0]
  end

  def hours
    if am?
      hour == '12' ? 0 : hour.to_i
    else
      hour == '12' ? 12 : hour.to_i + 12
    end
  end

end
