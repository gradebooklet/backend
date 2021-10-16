# frozen_string_literal: true

class V1::Users::AuthenticationController < ApiGuard::AuthenticationController
  before_action :authenticate_resource, only: [:destroy]

  def create
    if resource.authenticate(params[:user][:password])
      create_token_and_set_header(resource, resource_name)
      render jsonapi: resource, status: status
    else
      render jsonapi_errors: resource.errors, status: 422
    end
  end

  def destroy
    blacklist_token
    render_success(message: I18n.t('api_guard.authentication.signed_out'))
  end

  private

  def find_resource
    self.resource = resource_class.find_by(email: params[:user][:email].downcase.strip) if params[:user][:email].present?
    render_error(422, message: I18n.t('api_guard.authentication.invalid_login_credentials')) unless resource
  end

  def permitted_attrs
    devise_parameter_sanitizer.require(:user).permit(:sign_up, keys: [:username])
  end
end
