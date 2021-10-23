class V1::Users::PasswordsController < ApiGuard::PasswordsController
  before_action :find_user, only: [:reset_request, :reset]
  before_action :password_params, only: [:reset_request, :reset]

  # def update
  #   invalidate_old_jwt_tokens(current_resource)
  #
  #   if current_resource.update_attributes(password_params)
  #     blacklist_token unless ApiGuard.invalidate_old_tokens_on_password_change
  #     destroy_all_refresh_tokens(current_resource)
  #
  #     create_token_and_set_header(current_resource, resource_name)
  #     render_success(message: I18n.t('api_guard.password.changed'))
  #   else
  #     render_error(422, object: current_resource)
  #   end
  # end
  #

  def reset_request
    return render_default if @user.nil? or @user.password_token_valid?

    @user.generate_password_token!
    UserMailer.with(user: @user).reset_password_instructions.deliver_later

    render_default
  end

  def reset
    return render_error(422, message: "Token or Email invalid") unless token_matches_user

    reset_password
  end

  private

  def reset_password
    invalidate_old_jwt_tokens(@user)

    if @user.update(password: password_params[:password])
      blacklist_token unless ApiGuard.invalidate_old_tokens_on_password_change
      destroy_all_refresh_tokens(@user)
      create_token_and_set_header(@user, :user)
      reset_user_token

      render jsonapi: @user, status: :ok
    else
      render_error(422, message: @user.errors.full_messages)
    end
  end

  def token_matches_user
    @user.reset_password_token == password_params[:reset_token]
  end

  def render_default
    render_success(message: "Link has been sent if user exists")
  end

  def password_params
    params.require(:user).permit(:email, :password, :reset_token)
  end

  def reset_user_token
    @user.reset_password_sent_at = @user.reset_password_token = nil
    @user.save!
  end

  def find_user
    user_email = password_params[:email]
    @user = User.find_by(email: user_email.downcase.strip) if user_email.present?
  end
end
