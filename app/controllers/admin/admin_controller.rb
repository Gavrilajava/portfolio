module Admin
  class AdminController < ::ApplicationController
    LIMIT = 20

    before_action :authorize

    before_action :find_object, only: %i[edit update destroy]
    def index
      @offset = params.fetch(:offset, 0).to_i
      @limit = LIMIT
      @count = object_class.count
      @objects = object_class.order(default_order).offset(@offset).limit(@limit)
    end

    def edit; end

    def update
      return render_error unless @object.update(safe_params)

      flash[:notice] = "The #{object_class.to_s.titleize} is updated"
      redirect_to public_send("admin_#{object_class.table_name}_path")
    end

    def destroy
      return render_error unless @object.destroy

      flash[:notice] = "The #{object_class.to_s.titleize} is deleted"
      redirect_to public_send("admin_#{object_class.table_name}_path")
    end

    private

    def render_error
      flash[:error] = @object.errors.full_messages.join(', ')
      render :edit, status: :unprocessable_entity
    end

    def authorize
      return if current_user.admin?

      render 'layouts/unauthorized', status: :unauthorized
    end

    def find_object
      @object = object_class.find(params[:id]) or raise('not found')
    end

    def default_order
      { created_at: :desc }
    end
  end
end
