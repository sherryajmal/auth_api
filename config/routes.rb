Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    devise_for :users, skip: :all
    devise_scope :api_user do
      post 'users', to: 'users/registrations#create'
      get  'users/confirmation', to: 'users/confirmations#show'
    end
  	resources :sessions, only: [:create, :show] do
      collection do
        patch :update_profile
        delete :sign_out
      end
    end
  end
  
end
