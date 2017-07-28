module VoteableController
  extend ActiveSupport::Concern

  def create_vote(voteable)
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: voteable)

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash['notice'] = "Your vote was counted."
        else
          flash['error'] = "You can only vote on a #{vote.voteable_type.downcase} once."
        end

        redirect_to :back
      end

      format.js { render 'votes/vote' }
    end

  end
end
