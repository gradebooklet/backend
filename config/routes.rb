Rails.application.routes.draw do
  root to: 'static#index'

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

    post 'password_reset_request', to: 'v1/users/passwords#reset_request'
    post 'reset_password', to: 'v1/users/passwords#reset'
  end

  devise_for :users, skip: :all
end
