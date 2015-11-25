Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bucketlists
      post "auth/login"
      get "auth/logout"
      post "users/create"
      post "bucketlists/:id/items" => "items#create"
      put "bucketlists/:id/items/:id" => "items#update"
      delete "bucketlists/:id/items/:id" => "items#delete"
    end
  end


end