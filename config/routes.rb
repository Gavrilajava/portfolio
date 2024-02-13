Rails.application.routes.draw do
  devise_for :users, only: %i[sessions passwords registrations]

  get '/health_check', to: 'health_check#show'
  get '/health', to: 'health_check#show'

  root 'home#index'

  get 'contacts', to: 'contact_requests#new'
  post 'contact_requests', to: 'contact_requests#create'

  get 'groceries', to: 'groceries#index'

  namespace :admin do
    get 'users/offset/:offset', to: 'users#index', offset: /\d+/, as: 'users_offset'
    resources :users, except: %i[show create new]
    get 'contacts_requests/offset/:offset', to: 'contact_requests#index', offset: /\d+/, as: 'contacts_requests_offset'
    resources :contact_requests, except: %i[show create new]
  end
end
