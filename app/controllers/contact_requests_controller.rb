class ContactRequestsController < ApplicationController
  def new
    @contact_request = ContactRequest.new
  end

  def create
    @contact_request = ContactRequest.new(strong_params)
    if @contact_request.save
      flash[:notice] = 'Bam!'
      redirect_to root_path
    else
      flash[:error] = @contact_request.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def strong_params
    params.require(:contact_request).permit(:email, :message)
  end

  def set_active_nav_link
    @active_nav_link = :contacts
  end
end
