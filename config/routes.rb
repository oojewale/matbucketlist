Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :bucketlists
      post 'auth/login'
      get 'auth/logout'
    end
  end

end