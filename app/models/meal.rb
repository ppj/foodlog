class Meal < ActiveRecord::Base
  include Slugable
  set_slug_column_to :title

  belongs_to :user

  validates :title, length: {minimum: 3}

end
