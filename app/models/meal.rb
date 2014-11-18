class Meal < ActiveRecord::Base
  include Slugable
  set_slug_column_to :title

  belongs_to :user

  validates :description, length: {minimum: 5}

end
