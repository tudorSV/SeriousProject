Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :companies do
    resources :shops do
      resources :employees
    end
  end

  resources :users
  resources :sessions
  resources :welcome, only: :index

  get 'welcome/index'
  get 'signup',  to: 'users#new', as: 'signup'
  get 'signin',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
