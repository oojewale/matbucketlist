Rails.application.routes.draw do

  namespace :api do
  namespace :v1 do
    get 'users/create'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :bucketlists
      post "auth/login"
      get "auth/logout"
      namespace :bucketlists do
        post "items/create"
        put "items/update"
        delete "items/delete"
      end
    end
  end

end