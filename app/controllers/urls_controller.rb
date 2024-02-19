class UrlsController < ApplicationController
  def index; end

  def create
    url = Url.new(params.require(:url).permit(:long))
    if url.save
      render json: url, serializer: UrlSerializer
    else
      render json: { error: url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    url = Url.find_by(short: params[:short].downcase)
    redirect_to "https://#{url.long}", allow_other_host: true
  end

  def set_active_nav_link
    @active_nav_link = :urls
  end
end
