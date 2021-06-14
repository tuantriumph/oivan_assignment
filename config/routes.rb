Rails.application.routes.draw do
  
  scope module: 'admin' do
    resources :users
    resources :tests
    resources :questions, only: [:create, :update, :destroy] do
        post 'add_option', 'update_option', on: :member
        get 'destroy_option', on: :member
    end
    
  end
  
  root 'admin/users#index'
  
  get 'sessions/new'
  post 'sessions/create' 
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
  
  # default admin page
  #get '/', to: '/admin/users'
  #get '/admin', to: '/admin/users'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
