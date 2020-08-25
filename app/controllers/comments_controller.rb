class CommentsController < ApplicationController
  before_action :authorized, except: [:videocomments]
  # /comments#create

  def videocomments
    if Video.exists?(params[:video_id])
      if (@video_comments = Comment.where(video_id:params[:video_id])).empty?
        render :json => {
            :response => 'There are no comments to display'
        }
      else
        render :json => {
            :response => 'Here are the comments for this video',
            :data => @video_comments,
            :data2 => User.where(id:Comment.where(user_id:Video.where(id:params[:video_id])))
                # User.where(id:Comment.where(video_id:params[:video_id]))
          }
      end
    else
      render :json => {
          :response => 'This video does not exist'
      }
    end
  end

  def create
    @new_comment = Comment.new(comment_params)
    @new_comment.video_id = params[:video_id]
    @new_comment.user_id = params[:user_id]
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
    if Video.exists?(params[:video_id])
      if Comment.where(video_id:params[:video_id]).empty?
        render :json => {
            :response => 'There are no comments for this video'
        }
      else
        if @user.id == params[:user_id].to_i
          if (@video_comments = Comment.where(video_id:params[:video_id], user_id:params[:user_id], id:params[:id])).present?
            @video_comments.update(comment_params)
            render :json => {
              :response => 'Successfully updated comment',
              :data => @video_comments
            }
          else
            render :json => {
              :response => 'Cannot update the selected comment'
            }
          end
        else
          render :json => {
              :response => 'You are not authorized to edit this post',
              :responseTwo => @user.id,
              :responseThree => params[:user_id]
          }
        end
      end
    else
      render :json => {
          :response => 'Cannot find video'
      }
    end
  end

  def destroy
    if Video.exists?(params[:video_id])
      if Comment.where(video_id:params[:video_id]).empty?
        render :json => {
            :response => 'There are no comments for this video'
        }
      else
        if @user.id == params[:user_id].to_i
          if (@delete_comments = Comment.where(video_id:params[:video_id], user_id:params[:user_id], id:params[:id])).present?
            @delete_comments.destroy(params[:id])
            render :json => {
                :response => 'Successfully deleted comment',
                :data => @delete_comments
            }
          else
            render :json => {
                :response => 'Cannot delete the selected comment'
            }
          end
        else
          render :json => {
              :response => 'You are not authorized to delete this post',
              :responseTwo => params[:user_id]
          }
        end
      end
    else
      render :json => {
          :response => 'Cannot find video'
      }
    end
  end

  private
  def comment_params
    params.permit(:content, :user_id)
  end
end
