module ApplicationHelper
  def current_user
    session[:current_user]
  end

  def current_user?(user)
    user.id == current_user
  end
end
