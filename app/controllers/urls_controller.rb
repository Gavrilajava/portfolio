class UrlsController < ApplicationController
  def index; end

  def create
    debugger
  end

  def show
    url = Url.find_by(params[:id]) or raise('not found')
  end

  def set_active_nav_link
    @active_nav_link = :urls
  end
end
