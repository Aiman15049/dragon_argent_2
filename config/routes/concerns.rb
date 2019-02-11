concern :orderable do
  member do
    get :move_lower
    get :move_higher
    get :move_to_bottom
    get :move_to_top
  end
end

concern :publishable do
  member do
    get :toggle_publish
  end
end
