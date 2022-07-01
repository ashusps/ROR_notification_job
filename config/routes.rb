Rails.application.routes.draw do
  devise_for :users
  root to: "notifications#index"
  resources :notifications, only: %i[new create show index] do
    collection do 
      post :bulk_destroy
    end
  end
  get "notifications/approved/:id" => "notifications#approved"
end
