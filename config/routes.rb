Rails.application.routes.draw do
  namespace :api do
    post "auth/login"
    get "auth/logout"
    post "users/create"
    namespace :v1 do
      resources :bucketlists do
        post "items" => "items#create"
        put "items/:id" => "items#update"
        get "items/:id" => "items#show"
        delete "items/:id" => "items#destroy"
      end
    end
    match ":not_found" => "auth#invalid_endpoint", via: :all, constraints: { not_found: /.*/ }
  end
end
