class PostPublishingService

  attr_reader :post, :params, :tweet
  def initialize(post, params)
    @post = post
    @params = params
    @tweet = params[:tweet]
  end

  def save!
    post.publish_time = publish_time
    post.save!
    PublishPostWorker.perform_at(publish_time, post.id, tweet)
    true
  end

  def publish_time
    published ? Time.now : ActiveSupport::TimeZone[time_zone].parse(date) + seconds
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
