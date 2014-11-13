class Meal < ActiveRecord::Base
  belongs_to :user

  validates :description, length: {minimum: 5}

end
