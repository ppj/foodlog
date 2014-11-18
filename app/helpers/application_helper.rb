module ApplicationHelper

  def fix_time(time)
    if logged_in?
      time = time.in_time_zone(current_user.timezone)
    end
    time.strftime("(%d-%b-%Y %l:%M%P %Z)")
  end

end
