Rails.application.routes.draw do
  root 'homepage#home'
  get '/museum', to: 'homepage#museum', as: 'museum'
  get '/materials', to: 'homepage#materials', as: 'materials'
  get '/teachers', to: 'homepage#teachers', as: 'teachers'
  get '/history', to: 'homepage#history', as: 'history'
  get 'homepage/profile_list'
  get 'homepage/exit_profile_list'
  get 'get_image/:path', to: 'homepage#get_image'
  get 'homepage/search'
  
  get '/profile', to: 'profile#profile', as: 'profile'
  get '/change_password', to: 'profile#change_password'
  patch '/change_password/:id', to: 'profile#password_update'
  get 'profile/change/:id', to: 'profile#change'
  patch '/profile/update/:field/:id', to: 'profile#update'
  post '/profile/destroy/:id', to: 'profile#destroy'
  delete '/profile/destroy/:id', to: 'profile#confirm_destroy'
  post '/profile/cancel_destroy/:id', to: 'profile#cancel_destroy'
  get '/requests', to: 'request#admin', as: 'requests'
  get '/already_read', to: 'request#already_read'
  get '/send_request', to: 'request#send_request', as: 'send_request'
  get '/add_files', to: 'request#add_files', as: 'add_files'
  get '/request/change/:id', to: 'request#change_request'
  post '/request/change/:id', to: 'request#change'
  get '/my_requests', to: 'request#user_requests'
  post '/request/create'
  post '/request/read/:id', to: 'request#read'

  get '/admin', to: 'admin#users', as: 'admin'
  get '/users/edit/:id', to: 'admin#edit'
  get '/add_teacher', to: 'admin#add_teacher', as: 'add_teacher'
  get '/profile/edit_teacher/:id', to: 'admin#edit_teacher', as: 'edit_teacher'
  get '/list_teachers', to: 'admin#list_teachers', as: 'list_teachers'
  post '/create_teacher', to: 'admin#create_teacher', as: 'create_teacher'
  put '/update_teacher/:id', to: 'admin#update_teacher'
  patch '/set_admin/:id', to: 'admin#set_admin'
  get '/admin/add_users', as: 'add_users'
  post '/admin/create_users', as: 'create_users'

  get '/storage', to: 'storage#index'
  post '/storage/:type', to: 'storage#change'
  devise_for :users, path_name: { sign_up: 'registrations/new' }, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
