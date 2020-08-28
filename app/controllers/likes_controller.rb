class LikesController < ApplicationController
  before_action :authorized, only: [:destroy, :create]

  def show
    # Show video stats for one video
    if (Like.where(:video_id => params[:video_id])).empty?
      render :json => {
          :likes => 0,
          :dislikes => 0
      }
    else
      render :json => {
          :likes => Like.where(:video_id => params[:video_id], is_liked:true),
          :dislikes => Like.where(:video_id => params[:video_id], is_liked:false)
      }
    end
  end

  def showunique
    if Like.where(video_stats_params).empty?
      render :json => {
          :response => "empty",
          :data => Like.where(video_stats_params)
      }
    else
      render :json => {
          response => "not empty",
          :data => Like.where(video_stats_params)
      }
    end
  end

  def create
    # Check whether video_id is valid
    if (Like.where(video_stats_params)).empty?
      @new_like = Like.new(like_params)
      @new_like.save
      render :json => {
          :response => "liked/disliked!",
          :data => @new_like
      }
    else
      @user_like = Like.where(video_stats_params).ids
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
      @update_like = Like.update(video_stats_params, :is_liked => params[:is_liked])
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
      if Like.exists?(video_stats_params)
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

  def video_stats_params
    params.permit(:video_id, :user_id)
  end
end
