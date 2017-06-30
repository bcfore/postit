class CommentsController < ApplicationController
  def create
    @post = Post.find params.require(:post_id)
    @comment = Comment.new(comment_params)
    @comment.post = @post
    # @comment = @post.comments.build(comment_params) # equiv to the two above lines

    # TODO -- Assign the correct user to the comment:
    @comment.creator = User.first

    if @comment.save
      flash["notice"] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
