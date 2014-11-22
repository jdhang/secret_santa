Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/home', to: 'sessions#home'
  post '/pick', to: 'sessions#pick'

  get '/admin', to: 'admin#check'
  get '/admin/login', to: 'admin#new'
  post '/admin/login', to: 'admin#create'

  get '/admin/user/:id/confirm', to: 'admin/users#confirm', as: "confirm_admin_user"

  namespace :admin do
    resources :users
  end

end
