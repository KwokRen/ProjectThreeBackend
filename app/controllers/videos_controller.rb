class VideosController < ApplicationController
  before_action :authorized, except: [:index, :show, :create, :update]

  def index
    @all_videos = Video.all.order(id: :asc)
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
      @update_video.update(like_params)
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

  private

  def video_params
    params.permit(:title, :like_count, :dislike_count, :videoID, :thumb_default, :thumb_medium, :thumb_high)
  end

  def like_params
    params.permit( :like_count, :dislike_count)
  end

end
