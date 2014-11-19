class Meal < ActiveRecord::Base
  include Slugable
  set_slug_column_to :title

  include Voteable

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :plates
  has_many :foods, through: :plates
  has_many :comments, dependent: :destroy

  validates :title, length: {minimum: 3}

end
