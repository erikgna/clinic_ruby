class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: {
      message: 'Signed up sucessfully.',
      user: resource
    }
  end

  def register_failed
    render json: {
      message: "Something went wrong."
    }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin])
  end
end