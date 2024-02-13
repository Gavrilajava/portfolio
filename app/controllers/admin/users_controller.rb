module Admin
  class UsersController < AdminController
    private

    def set_active_nav_link
      @active_nav_link = :users
    end

    def safe_params
      safe_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
      safe_params = safe_params.except(:password, :password_confirmation) if safe_params[:password].blank?
      safe_params
    end

    def object_class
      User
    end

    def default_order
      { role: :desc, created_at: :desc }
    end
  end
end
