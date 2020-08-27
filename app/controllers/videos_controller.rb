class VideosController < ApplicationController
  before_action :authorized, except: [:index, :show, :create, :get_likes]

  def index
    @all_videos = Video.all
    if @all_videos
      render :json => {
          status: "Success",
          response: @all_videos
      }
    else
      render :json => {
          status: "Fail",
          error: "No videos found"
      }
    end
  end

  def show
    @one_video = Video.exists?(params[:id])
    if @one_video
      render :json => {
          :response => 'Found Video Successful',
          :data => Video.find(params[:id])
      }
    else
      render :json => {
          :response => 'No Video Found'
      }
    end
  end

  def update
    @update_video = Video.where(id:params[:id])
    if @update_video.empty?
      render :json => {
          :response => "This video does not exist"
      }
    else
      @update_video.update(video_likes_and_dislikes_params)
      render :json => {
          :data => @update_video
      }
    end
  end

  def create
    @new_video = Video.new(video_params)
    if @new_video.save
      render :json => {
          :response => "Success",
          :data => @new_video
      }
    else
      render :json => {
          :error => "Could not create video"
      }
    end
  end


  def get_likes

    if !(Like.where(video_id:params[:video_id])).empty?
      render :json => {
          :likes => Like.where(video_id:params[:video_id], is_liked:true).count,
          :dislikes => Like.where(video_id:params[:video_id], is_liked:false).count
      }
    else
      render :json => {
          :likes => 0,
          :dislikes => 0
      }
    end
  end

  def changeVote

    if Like.exists?(video_id:params[:video_id], user_id:params[:user_id])
      @update_is_liked = Like.update(is_liked:params[:is_liked])
      render :json => {
          :response => "Changed value",
          :data => @update_is_liked
      }
    else
      render :json => {
          :response => "Created like"
      }
    end

  end

  private


  def video_likes_and_dislikes_params
    params.permit(:video_id, :user_id, :is_liked)
  end

  def video_params
    params.permit(:title, :like_count, :dislike_count, :videoID, :thumb_default, :thumb_medium, :thumb_high)
  end

end
