module Admin
  class ContactRequestsController < AdminController
    private

    def safe_params
      params.require(:contact_request).permit(:status)
    end

    def set_active_nav_link
      @active_nav_link = :contacts
    end

    def object_class
      ContactRequest
    end
  end
end
