Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/login"
      get "auth/logout"
      post "users/create"
      resources :bucketlists do
        post "items" => "items#create"
        put "items/:id" => "items#update"
        delete "items/:id" => "items#destroy"
      end
    end
  end
end
