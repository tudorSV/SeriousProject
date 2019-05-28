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
    resources :appointments, except: [:index] do
      resources :notes, only: [:new, :create]
    end
    put :change_status
    put :block_user
  end

  resources :sessions

  get 'new_contact_message', to: 'contacts#new', as: 'new_contact_message'
  post 'create_contact_message', to: 'contacts#create', as: 'create_contact_message'

  get 'users_list', to: 'users#index_admin', as: 'users_list'
  get 'signup',  to: 'users#new', as: 'signup'
  get 'signin',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'recoverPassword', to: 'users#recoverPassword'
end
