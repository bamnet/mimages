Rails.application.routes.draw do
  root "photos#index"

  resources :photos, only: :show, path: "v1/photos", param: :uuid
  resources :photos, except: :show
end
