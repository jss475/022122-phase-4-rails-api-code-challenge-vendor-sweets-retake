Rails.application.routes.draw do
  resources :vendors, only: [:index, :show]
  resources :sweets, only: [:index, :show]
  resources :vendor_sweets, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
