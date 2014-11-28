class Meal < ActiveRecord::Base
  Categories = ['Coffee/Tea', 'Breakfast', 'Brunch', 'Snack', 'Lunch', 'Dinner', 'Supper']

  include Slugable
  set_slug_column_to :name

  include Voteable

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :plates, dependent: :destroy
  has_many :foods, through: :plates
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, length: {minimum: 3}

  validates :category, inclusion: { in: Categories, message: "'%{value}' is not valid" }

  validates :foods, length: { minimum: 1, message: "cannot be empty (at least 1 food needs to be selected)" }
end
