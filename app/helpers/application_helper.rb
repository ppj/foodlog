module ApplicationHelper

  def fix_time(time)
    if logged_in?
      time = time.in_time_zone(current_user.timezone)
    end
    time.strftime("(%d-%b-%Y %l:%M%P %Z)")
  end

  def link_based_on_current_users_vote_on_meal(meal_object, value)
    if Vote.find_by(creator: current_user, vote: value, voteable: meal_object)
      link_to vote_destroy_meal_path(meal_object), method: 'delete', remote: true do
        "<span class='glyphicon glyphicon-fire'></span>".html_safe
      end
    else
      icon = value ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
      link_to vote_meal_path(meal_object, vote: value), method: 'post', remote: true do
        icon.html_safe
      end
    end
  end

  def link_based_on_current_users_vote_on_comment(comment_object, value)
    if Vote.find_by(creator: current_user, vote: value, voteable: comment_object)
      link_to vote_destroy_meal_comment_path(comment_object.meal, comment_object), method: 'delete', remote: true do
        "<span class='glyphicon glyphicon-fire'></span>".html_safe
      end
    else
      icon = value ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
      link_to vote_meal_comment_path(comment_object.meal, comment_object, vote: value), method: 'post', remote: true do
        icon.html_safe
      end
    end
  end

end
