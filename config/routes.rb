Rails.application.routes.draw do
  devise_for :users, only: %i[sessions passwords registrations], controllers: { sessions: 'sessions' }

  get '/health_check', to: 'health_check#show'
  get '/health', to: 'health_check#show'

  root 'home#index'

  get 'contacts', to: 'contacts#index'

  get 'groceries', to: 'groceries#index'
end
