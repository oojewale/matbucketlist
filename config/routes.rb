Rails.application.routes.draw do
  root "api/v1/users#index"
  namespace :api do
    namespace :v1 do
      post "auth/login"
      get "auth/logout"
      post "users/create"
      resources :bucketlists do
        post "items" => "items#create"
        put "items/:id" => "items#update"
        get "items/:id" => "items#show"
        delete "items/:id" => "items#destroy"
      end
      match ":not_found" => "auth#invalid_endpoint", via: :all, constraints: { not_found: /.*/ }
    end
  end
end
