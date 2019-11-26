module ApplicationHelper
  def cookie_index
    cookies[:"actions"] % 5 == 0
  end
end
