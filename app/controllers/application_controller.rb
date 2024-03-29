class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_active_nav_link

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name email password password_confirmation acknowledgement])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation])
  end

  def not_found
    return render json: { error: :not_found }, status: :not_found if request.format.json?

    render 'layouts/errors/not_found', status: :not_found
  end

  def set_active_nav_link
    @active_nav_link = :home
  end
end
