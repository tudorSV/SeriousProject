Rails.application.routes.draw do
   root :to => "sessions#new"
  resources :companies do
    resources :shops do
      resources :employees
    end
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup',  to: 'users#new', as: 'signup'
  get 'signin',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
