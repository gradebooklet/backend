class V1::Users::TokensController < ApiGuard::TokensController
  before_action :authenticate_resource, only: [:create]
  before_action :find_refresh_token, only: [:create]

  def create
    create_token_and_set_header(current_resource, resource_name)

    @refresh_token.destroy
    blacklist_token if ApiGuard.blacklist_token_after_refreshing

    render_success(message: I18n.t('api_guard.access_token.refreshed'))
  end
end
