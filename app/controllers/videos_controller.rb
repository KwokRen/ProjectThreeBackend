class VideosController < ApplicationController
  before_action :authorized, except: [:index, :show, :create]

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
  private
  def video_params
    params.permit(:title, :like_count, :dislike_count, :videoID, :thumb_default, :thumb_medium, :thumb_high)
  end

end
