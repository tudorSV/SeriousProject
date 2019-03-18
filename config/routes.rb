Rails.application.routes.draw do
   root :to => "companies#home"
  resources :companies do
    resources :shops
  end
  # resources :addresses

end
