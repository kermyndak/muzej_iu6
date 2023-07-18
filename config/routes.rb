Rails.application.routes.draw do
  root 'homepage#home'
  get 'profile/admin_profile'
  get 'profile/profile'
  get 'profile/edit/:id', to: 'profile#edit'
  get 'profile/set_admin/:id', to: 'profile#set_admin'
  get 'profile/change_role'
  get 'request/index'
  get 'profile/change/:id', to: 'profile#change'
  put 'profile/update/:field/:id', to: 'profile#update'
  devise_for :users, path_name: { sign_up: 'registrations/new' }, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
