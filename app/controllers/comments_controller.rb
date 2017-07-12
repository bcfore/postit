class CommentsController < ApplicationController
  before_action :require_user

  include VoteableController

  def create
    @post = Post.find params.require(:post_id)
    @comment = Comment.new(comment_params)
    @comment.post = @post
    # @comment = @post.comments.build(comment_params) # equiv to the two above lines

    @comment.creator = current_user

    if @comment.save
      flash["notice"] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def vote
    comment = Comment.find(params[:id])
    create_vote(comment)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
