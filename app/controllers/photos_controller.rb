# frozen_string_literal: true

class PhotosController < ApplicationController
  skip_before_action :require_auth!, only: %i[index show map]

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
    unless current_user.allowed_uploader
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

  def map
    @photo = Photo.find_by(uuid: params[:uuid])

    conn = Faraday.new(
      'https://maps.googleapis.com',
      request: { timeout: 5 },
      params: {
        key: Rails.application.credentials[:maps_api_key],
        channel: Rails.env
      }
    )
    result = conn.get(
      '/maps/api/staticmap', {
        center: "#{@photo.latitude},#{@photo.longitude}",
        zoom: 18,
        size: '960x300',
        maptype: 'hybrid',
        markers: "color:red|#{@photo.latitude},#{@photo.longitude}"
      },
      { 'User-Agent': 'mimages' }
    )

    # Copy over a bunch of caching headers.
    %w[Cache-Control Date Expires].each do |h|
      response.headers[h] = result.headers[h.downcase] if result.headers.key?(h.downcase)
    end

    send_data result.body, type: result.headers['content-type'], disposition: 'inline'
  end

  def destroy
    @photo = Photo.find_by(uuid: params[:uuid])
    if @photo.user != current_user
      return head :unauthorized
    else
      @photo.destroy

      redirect_to root_path, status: :see_other
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :photo, :captured_at, :latitude, :longitude)
  end
end
