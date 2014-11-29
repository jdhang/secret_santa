Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/home', to: 'sessions#home'
  post '/pick', to: 'sessions#pick'
  get '/wishlist', to: 'sessions#wishlist'
  post '/wishlist/match', to: 'sessions#match_wishlist'

  get '/admin', to: 'admin#check'
  get '/admin/login', to: 'admin#new'
  post '/admin/login', to: 'admin#create'

  get '/admin/user/:id/confirm', to: 'admin/users#confirm', as: "confirm_admin_user"

  post '/items/:id/back', to: 'items#back_row', as: "back_row"
  resources :items, except: [:show, :index] do
    member do
      post :edit_row
    end
  end

  namespace :admin do
    resources :users
  end

end
