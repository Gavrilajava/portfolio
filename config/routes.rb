Rails.application.routes.draw do
  devise_for :users, only: %i[sessions passwords registrations]

  get '/health_check', to: 'health_check#show'
  get '/health', to: 'health_check#show'

  root 'home#index'

  get 'contacts', to: 'contact_requests#new'
  post 'contact_requests', to: 'contact_requests#create'

  get 'groceries', to: 'groceries#index'
end
