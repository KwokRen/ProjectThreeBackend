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
      if (Like.where(video_stats_params)).empty?
        # if there is no like in DB then create i
        @new_like = Like.create(like_params)
        render :json => {
            :response => "liked/disliked!"
        }
      else
        # If there is a like compare with :is_liked
        # If values don't match, update
        if (@user_like = Like.where(video_stats_params, is_liked:params[:is_liked])).empty?
          @updated_like = Like.update(@user_like.ids, is_liked:params[:is_liked])
          render :json => {
              :response => "updated is_liked value"
          }
        else
          # if a record is found then destroy the record
          Like.destroy(@user_like.ids)
          render :json => {
              :response => "Removed record",
              :data => @user_like
          }
        end
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
