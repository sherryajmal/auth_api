Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    devise_for :users, controllers: { registrations: 'v1/users/registrations', confirmations: 'v1/users/confirmations'}
  	resources :sessions, only: [:create, :destroy, :update]
  end
  
end
