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

  def update
    if (@single_update_comment = Comment.find(params[:id])).present?
      @single_update_comment.update(comment_params)
      render :json => {
          :response => 'Successfully updated comment',
          :data => @single_update_comment
      }
    else
      render :json => {
          :response => 'Cannot update the selected comment'
      }
    end
  end

  def destroy
    if (@single_destroy_comment = Comment.find(params[:id])).present?
      @single_destroy_comment.destroy
      render :json => {
          :response => "Successfully deleted the selected comment.",
          :data => @single_destroy_comment
      }
    else
      render :json => {
          :error => 'The selected comment cannot be deleted.'
      }
    end
  end

  private
  def comment_params
    params.permit(:content, :user_id)
  end
end
