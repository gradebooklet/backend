class UserMailer < ApplicationMailer
  default from: "<#{ENV['NOTIFICATIONS_FROM_EMAIL']}>"
  before_action :add_inline_attachments!

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to gradebooklet')
  end


  def reset_password_instructions
    @user = params[:user]
    @url = 'https://gradebooklet-app.com/account/reset-password?t=' << @user.reset_password_token
    mail(to: @user.email, subject: 'gradebooklet Account password reset')
  end

  private

  def add_inline_attachments!
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
  end
end
