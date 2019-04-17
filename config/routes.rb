Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    post 'users', to: 'users/registrations#create'
    get  'users/confirmation', to: 'users/confirmations#show'
  	resources :sessions, only: [:create, :destroy, :update]
  end
  
end
