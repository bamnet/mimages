# frozen_string_literal: true

Rails.application.routes.draw do
  # Health check for Once deployment
  get 'up', to: proc { [200, {}, ['OK']] }

  get 'sign_in', to: 'sessions#new'
  delete 'sign_out', to: 'sessions#destroy'
  get  '/auth/failure',            to: 'sessions/omniauth#failure'
  get  '/auth/:provider/callback', to: 'sessions/omniauth#create'
  post '/auth/:provider/callback', to: 'sessions/omniauth#create'

  root 'photos#index'

  resources :photos, only: %i[show destroy], path: 'v1/photos', param: :uuid
  resources :photos, param: :uuid do
    get 'map', on: :member
  end
end
