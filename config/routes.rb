Rails.application.routes.draw do
   root :to => "companies#home"
   get 'show', to: 'companies#show'
   get 'create', to: 'companies#new'
   post 'create', to: 'companies#create'
   put 'edit', to: 'companies#edit'
  ## get 'delete', to: 'companies#destroy'
  ## get 'showShops', to: 'shops#showS'
  resources :companies
end
