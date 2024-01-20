Rails.application.routes.draw do
  
  root 'home#index'

  get 'help', to: 'help#index'

  get 'groceries', to: 'groceries#index'

end
