class UrlsController < ApplicationController
  def index; end

  def set_active_nav_link
    @active_nav_link = :urls
  end
end
