class Food < ActiveRecord::Base

  has_many :plates
  has_many :meals, through: :plates

end
