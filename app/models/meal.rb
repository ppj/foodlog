class Meal < ActiveRecord::Base
  include Slugable
  set_slug_column_to :title

  include Voteable

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :title, length: {minimum: 3}

end
