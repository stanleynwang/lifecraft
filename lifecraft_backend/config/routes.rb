Lifecraft::Application.routes.draw do
  root :to => 'users#new'
  # Users
  resources :users
  resource :user, :as => :account

  match 'signup' => "users#new", :as => :signup

  # User Sessions
  resources :user_sessions
  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  namespace :api do
    resources :users
    resources :user_sessions
    # match :logout => 'user_sessions#destroy' , :as => :logout
    # match :signup => 'users#new',              :as => :signup
  end
  match 'api/login'  => 'api/user_sessions#create',  :as => :'api/login'
  match 'api/logout' => 'api/user_sessions#destroy', :as => :'api/logout'
  match 'api/signup' => 'api/users#create',          :as => :'api/signup'
end
