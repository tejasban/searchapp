Rails.application.routes.draw do
  resources :products, only: [:index, :show]
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
