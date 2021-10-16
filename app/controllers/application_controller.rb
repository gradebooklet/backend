class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters if :devise_controller?
  include ActionController::MimeResponds

  respond_to :json

  def render_jsonapi_response(resource, status = :ok)
    if resource.errors.empty?
      render jsonapi: resource, status: status
    else
      render jsonapi_errors: resource.errors, status: 400
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
