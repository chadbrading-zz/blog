module ApplicationHelper
  def current_user
    session[:current_user]
  end

  def current_user?(user)
    user.id == current_user
  end

  def hours
    ['12:00 am'] + (1..11).map { |n| "#{n}:00 am"} +
      ['12:00 pm'] + (1..11).map { |n| "#{n}:00 pm"}
  end

  def dates
    today = Time.now.to_date
    (0..365).map { |day| today + day }
  end
end
