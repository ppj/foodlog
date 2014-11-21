class Meal < ActiveRecord::Base
  include Slugable
  set_slug_column_to :name

  include Voteable

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :plates
  has_many :foods, through: :plates
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, length: {minimum: 3}

end
