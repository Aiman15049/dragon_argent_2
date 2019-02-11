namespace :cms do
  root to: 'dashboard#index'
  get '/contacts', to: 'contact_forms#contacts'
  resources :admins, param: :admin_id
  resources :assets, param: :asset_id, only: :destroy
  resources :contact_forms, param: :contact_form_id, only: [:index, :show, :destroy]
  resources :downloadable_categories, param: :downloadable_category_id, path: 'downloadable-categories'
  resources :downloadables, param: :downloadable_id
  resources :dynamic_pages, param: :dynamic_page_id,
                            concerns: %i[orderable publishable] do
    member do
      get :new_child
    end
  end

end
