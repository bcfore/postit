class Post < ActiveRecord::Base
  include VoteableNolly
  include SluggableNolly

  PER_PAGE = 3

  default_scope { order('created_at ASC') }

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 3}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  sluggable_column :title

  API_KEYS = [ :title, :url, :description, :created_at, :updated_at ]

  # def to_xml(options)
  #   self.slice(*API_KEYS).to_xml(options)
  # end

  def to_xml(options = {})
    super(options.merge({ only: API_KEYS }))
  end

  def as_json(options = {})
    super(options.merge({ only: API_KEYS }))
  end
end
