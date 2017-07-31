# Originally I had this in 'app/models/concerns'
# but then I created a Voteable gem, pushed to rubygems.org.
#
module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    votes.where(vote: true).size
  end

  def down_votes
    votes.where(vote: false).size
  end
end
