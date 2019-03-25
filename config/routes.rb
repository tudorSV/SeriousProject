Rails.application.routes.draw do
  resources :companies do
    resources :shops
  end
end
