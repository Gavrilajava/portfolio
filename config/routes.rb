Rails.application.routes.draw do
  devise_for :users, only: %i[sessions passwords registrations]

  get '/health_check', to: 'health_check#show'
  get '/health', to: 'health_check#show'

  root 'home#index'

  get 'contacts', to: 'contact_requests#new'
  post 'contact_requests', to: 'contact_requests#create'

  get 'urls', to: 'urls#index'
  post 'urls', to: 'urls#create'
  get '/s/(:short)', to: 'urls#show', as: 'url_redirect'

  namespace :admin do
    get 'users/offset/:offset', to: 'users#index', offset: /\d+/, as: 'users_offset'
    resources :users, only: %i[index edit update destroy]
    get 'contacts_requests/offset/:offset', to: 'contact_requests#index', offset: /\d+/, as: 'contacts_requests_offset'
    resources :contact_requests, only: %i[index edit update destroy]
  end
end
