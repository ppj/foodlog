module ApplicationHelper

  def fix_time(time)
    if logged_in?
      time = time.in_time_zone(current_user.timezone)
    end
    time.strftime("(%d-%b-%Y %l:%M%P %Z)")
  end

  def get_meal_time(meal, format)
    meal_time = meal.new_record? ? Time.now : meal.time
    meal_time = meal_time.in_time_zone(current_user.timezone) if logged_in?
    meal_time = meal_time.strftime(format)
  end

  def edit_link(edit_path)
    if logged_in?
      link_to(edit_path) do
        "<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>".html_safe
      end
    end
  end


  def link_based_on_current_users_vote_on_meal(meal_object, value)
    if Vote.find_by(creator: current_user, vote: value, voteable: meal_object)
      link_to vote_destroy_meal_path(meal_object), method: 'delete', remote: true do
        "<span class='glyphicon glyphicon-remove-circle'></span>".html_safe
      end
    else
      icon = value ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
      link_to vote_meal_path(meal_object, vote: value), method: 'post', remote: true do
        icon.html_safe
      end
    end
  end

  def link_based_on_current_users_vote_on_meal_comment(comment_object, value)
    if Vote.find_by(creator: current_user, vote: value, voteable: comment_object)
      link_to vote_destroy_meal_comment_path(comment_object.commentable, comment_object), method: 'delete', remote: true do
        "<span class='glyphicon glyphicon-remove-circle'></span>".html_safe
      end
    else
      icon = value ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
      link_to vote_meal_comment_path(comment_object.commentable, comment_object, vote: value), method: 'post', remote: true do
        icon.html_safe
      end
    end
  end

  def link_based_on_current_users_vote_on_food(food_object, value)
    if Vote.find_by(creator: current_user, vote: value, voteable: food_object)
      link_to vote_destroy_food_path(food_object), method: 'delete', remote: true do
        "<span class='glyphicon glyphicon-remove-circle'></span>".html_safe
      end
    else
      icon = value ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
      link_to vote_food_path(food_object, vote: value), method: 'post', remote: true do
        icon.html_safe
      end
    end
  end

  def link_based_on_current_users_vote_on_food_comment(comment_object, value)
    if Vote.find_by(creator: current_user, vote: value, voteable: comment_object)
      link_to vote_destroy_food_comment_path(comment_object.commentable, comment_object), method: 'delete', remote: true do
        "<span class='glyphicon glyphicon-remove-circle'></span>".html_safe
      end
    else
      icon = value ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
      link_to vote_food_comment_path(comment_object.commentable, comment_object, vote: value), method: 'post', remote: true do
        icon.html_safe
      end
    end
  end

end
