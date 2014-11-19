class Plate < ActiveRecord::Base
  belongs_to :meal
  belongs_to :food
end
