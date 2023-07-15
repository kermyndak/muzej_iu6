Rails.application.routes.draw do
  root 'homepage#home'
  devise_for :users, path_name: { sign_up: 'registrations/new' }, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
