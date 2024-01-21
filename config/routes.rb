Rails.application.routes.draw do
  
  root 'home#index'

  get 'contacts', to: 'contacts#index'

  get 'groceries', to: 'groceries#index'

end
