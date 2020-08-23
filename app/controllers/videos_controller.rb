class VideosController < ApplicationController
  before_action :authorized, except: [:index]

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
          :data => @one_video
      }
    else
      render :json => {
          :response => 'No Video Found'
      }
    end
  end

end
