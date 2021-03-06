class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true

  # validates :creator, uniqueness: { scope: :voteable }
  # Equivalent, but more compact:
  # validates_uniqueness_of :creator, scope: :voteable
  validates_uniqueness_of :creator, scope: [:voteable_id, :voteable_type]
end
