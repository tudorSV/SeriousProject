Rails.application.routes.draw do
   root :to => "companies#home"
   # get 'show', to: 'companies#show'
   # get 'create', to: 'companies#new'
   # post 'create', to: 'companies#create'
   # put 'edit', to: 'companies#edit'
   # delete 'delete', to: 'companies#delete'
   # get 'index', to: 'companies#index'
   # get 'createAddress', to: 'addresses#new'
   # post 'createAddress', to: 'addresses#create'
   # get 'show', to: 'addresses#show'
   # get 'edit', to: 'addresses#edit'
   # put 'edit', to: 'addresses#edit'
   # delete 'delete', to: 'addresses#delete'
   # get 'index', to: 'addresses#index'
   # get 'createShop', to: 'shops#new'
   # post 'createShop', to: 'shops#create'

  resources :companies do
    resources :shops
  end
  # resources :addresses

end
