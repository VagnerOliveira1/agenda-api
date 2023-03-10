Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'

  namespace :admin do
    namespace :v1, defaults:{format: :json} do
      get "home" => "home#index"
      resources :contacts do 
        resources :address
      end
    end
  end

  namespace :front do
    namespace :v1 do
    end
  end
end
