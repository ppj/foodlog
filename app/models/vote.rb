class Vote < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name :user
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :creator, scope: [:voteable_type, :voteable_id]

end
