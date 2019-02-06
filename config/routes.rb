Rails.application.routes.draw do
  get 'admin/index'
  get 'home/index'
  root 'home#index'
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
