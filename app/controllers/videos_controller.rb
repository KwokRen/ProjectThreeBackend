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
end
