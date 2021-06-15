Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#login'
      
      scope :student do
        get 'all_tests', to: 'students#list'
        get 'get_test/:id', to: 'students#show'
        get 'logout', to: 'students#logout'
      end
      
      post 'student/save_result', to: 'students#save_test_result'
    end
  end
  
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
