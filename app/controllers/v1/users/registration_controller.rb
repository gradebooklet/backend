class V1::Users::RegistrationController < ApiGuard::RegistrationController
  # before_action :authenticate_resource, only: [:destroy]

  def create
    init_resource(sign_up_params)
    if resource.save
      create_token_and_set_header(resource, resource_name)

      # Tell the UserMailer to send a welcome email after save
      UserMailer.with(user: resource).welcome_email.deliver_later

      render jsonapi: resource, status: :created
    else
      render jsonapi_errors: resource.errors, status: 400
    end
  end

  # def destroy
  #   current_resource.destroy
  #   render_success(message: I18n.t('api_guard.registration.account_deleted'))
  # end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :username)
  end
end
