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
          :likes => Like.where(:video_id => params[:video_id], is_liked:true).count,
          :dislikes => Like.where(:video_id => params[:video_id], is_liked:false).count
      }
    end
  end

  def show_user_vote
    if (@user_vote = Like.where(video_stats_params)).empty?
      render :json => {
          :response => "no vote"
      }
    else
      render :json => {
          :response => "voted",
          :data => @user_vote
      }
    end
  end

  def create
    #Check whether user_id field is valid
    if !params[:user_id].empty?
      @user_like = Like.where(video_stats_params)[0]
      if !@user_like
        # if there is no like in DB then create i
        @new_like = Like.create(like_params)
        render :json => {
            :response => "liked/disliked!"
        }
      elsif @user_like[:is_liked] == params[:is_liked]
        # if a record is found then destroy the record
        @user_like.destroy
        render :json => {
            :response => "Removed record",
            :data => @user_like
        }
      else
        @user_like.update(is_liked:params[:is_liked])
        render :json => {
              :response => "updated is_liked value"
          }
      end
    else
      render :json => {
          :response => "Log in to vote"
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
        @record = Like.where(video_id:params[:video_id], user_id:params[:user_id]).ids
        Like.destroy(@record)
        render :json => {
            :response => "Removed record"
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
