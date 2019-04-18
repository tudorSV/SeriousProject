Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :companies do
    resources :shops do
      resources :employees
      resources :shop_slots, except: [:index, :show]
      get :index_appointment
      put :change_status
    end
  end

  resources :users do
    resources :appointments, except: [ :index]
  end

  resources :sessions

  get 'signup',  to: 'users#new', as: 'signup'
  get 'signin',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'recoverPassword', to: 'users#recoverPassword'
end
