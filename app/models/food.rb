class Food < ActiveRecord::Base
  include Slugable
  set_slug_column_to :name

  include Voteable

  belongs_to :creator, class_name: 'User'

  has_many :plates
  has_many :meals, through: :plates
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, length: {minimum: 2}, uniqueness: true

end
