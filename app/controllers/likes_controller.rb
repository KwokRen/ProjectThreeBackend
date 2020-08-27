class LikesController < ApplicationController
  before_action :authorized, only: [:destroy, :create]

  def show
    # Show video stats for one video
    
  end
  def create
    # Check whether video_id is valid
    if (Like.where(:user_id => params[:user_id], :video_id => params[:video_id])).empty?
      @new_like = Like.new(like_params)
      @new_like.save
      render :json => {
          :response => "liked/disliked!"
      }
    else
      @user_like = Like.where(:user_id => params[:user_id], :video_id => params[:video_id]).ids
      Like.destroy(@user_like)
      render :json => {
          :response => "Removed like/dislike",
          :data => @user_like
      }
    end

  end

  def update
    # First check if like is in database
    if (Like.where(like_params)).empty?
      @update_like = Like.update(user_id:params[:user_id], video_id:params[:video_id] , :is_liked => params[:is_liked])
      render :json => {
          :response => "Updated like",
          :data => @update_like
      }
    else
      render :json => {
          :error => "removed value"
      }
    end
  end


  def destroy
      if Like.exists?(video_id:params[:video_id], user_id:params[:user_id])
        # should return one
        @record = Like.where(video_id:params[:video_id], user_id:params[:user_id]).ids
        render :json => {
            :response => "Removed record",
            :data => @record.ids
        }
      end
  end

  private
  def like_params
    params.permit(:video_id, :user_id, :is_liked)
  end
end
