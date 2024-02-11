class GroceriesController < ApplicationController
  def index; end

  def set_active_nav_link
    @active_nav_link = :groceries
  end
end
