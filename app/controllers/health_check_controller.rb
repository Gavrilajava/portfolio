class HealthCheckController < ApplicationController

  def show
    render json: :ok, status: :ok
  end
  
end
