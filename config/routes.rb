Rails.application.routes.draw do
  get  "sign_in", to: "sessions#new"
  resources :sessions, only: [:index, :show, :destroy]
  get  "/auth/failure",            to: "sessions/omniauth#failure"
  get  "/auth/:provider/callback", to: "sessions/omniauth#create"
  post "/auth/:provider/callback", to: "sessions/omniauth#create"

  root "photos#index"

  resources :photos, only: :show, path: "v1/photos", param: :uuid
  resources :photos, except: :show
end
