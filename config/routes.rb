class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  get 'admin/index'
  get 'home/index'
  root 'home#index'
  devise_for :admins
  draw :cms
  resources :dynamic_pages
  concern :orderable do
  member do
    get :move_lower
    get :move_higher
    get :move_to_bottom
    get :move_to_top
  end
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
