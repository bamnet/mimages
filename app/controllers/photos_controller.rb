class PhotosController < ApplicationController
  skip_before_action :require_auth!, only: [:index, :show]

  def index
    @photos = Photo.all
  end 

  def show
    @photo = Photo.find_by(uuid: params[:uuid])
  end

  def new
    @photo = Photo.new
  end

  def create
    if !current_user.allowed_uploader
      head :forbidden
      return
    end

    @photo = Photo.new(photo_params)
    @photo.user = current_user

    if @photo.save
      redirect_to @photo
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :photo, :captured_at, :latitude, :longitude)
  end
end
