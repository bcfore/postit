module VoteableController
  extend ActiveSupport::Concern

  def create_vote(voteable)
    vote = Vote.new(vote: params[:vote], creator: current_user, voteable: voteable)

    if vote.save
      flash['notice'] = "Your vote was counted."
    else
      flash['error'] = "You can only vote on a #{vote.voteable_type.downcase} once."
    end

    redirect_to :back
  end
end
