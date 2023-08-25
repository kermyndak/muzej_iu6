Rails.application.routes.draw do
  root 'homepage#home'
  get 'profile/admin_profile'
  get 'profile/profile'
  get 'profile/edit/:id', to: 'profile#edit'
  put 'profile/set_admin/:id', to: 'profile#set_admin'
  get 'request/admin'
  get 'request/already_read'
  get 'request/send_request'
  post 'request/create'
  post 'request/read/:id', to: 'request#read'
  get 'profile/change/:id', to: 'profile#change'
  put 'profile/update/:field/:id', to: 'profile#update'
  post 'profile/destroy/:id', to: 'profile#destroy'
  post 'profile/cancel_destroy/:id', to: 'profile#cancel_destroy'
  delete 'profile/confirm_destroy/:id', to: 'profile#confirm_destroy'
  devise_for :users, path_name: { sign_up: 'registrations/new' }, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
