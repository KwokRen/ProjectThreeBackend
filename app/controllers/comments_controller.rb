class CommentsController < ApplicationController
  before_action :authorized
  # /comments#create
  def create
    @new_comment = Comment.new(comment_params)
    if @new_comment.save
      render :json => {
          response: "created comment",
          data: @new_comment
      }
    else
      render :json => {
          error: "Cannot save data"
      }
    end
  end

  private
  def comment_params
    params.permit(:content, :user_id)
  end
end
