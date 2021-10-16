Rails.application.routes.draw do
  default_url_options :host => ENV['BASE_URL']

  # namespace :api, defaults: { format: :json } do
  #   resources :users, only: :show
  #
  #   get 'current_user', to: 'users#current_user', as: :current_user
  # end

  scope path: 'v1/' do
    api_guard_routes for: 'users',
                     path: '',
                     defaults: {
                       format: :json
                     },
                     controller: {
                       registration: 'v1/users/registration',
                       authentication: 'v1/users/authentication',
                       passwords: 'v1/users/passwords',
                       tokens: 'v1/users/tokens'
                     }

    get 'subjects', to: 'v1/subjects#index'
  end

  devise_for :users, skip: :all
    # path: '',
    # defaults: { format: :json },
    # path_names: {
    #   sign_in: 'api/login',
    #   sign_out: 'api/logout',
    #   registration: 'api/signup'
    # },
    # controllers: {
    #   sessions: 'api/users/sessions',
    #   registrations: 'api/users/registrations'
    # }
end
