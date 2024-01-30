Rails.application.routes.draw do

  get '/health_check', to: 'health_check#show'
  
  root 'home#index'

  get 'contacts', to: 'contacts#index'

  get 'groceries', to: 'groceries#index'

end
