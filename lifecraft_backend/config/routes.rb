Lifecraft::Application.routes.draw do
  # Users
  resources :users
  resource :user, :as => :account

  match 'signup' => "users#new", :as => :signup

  # User Sessions
  resources :user_sessions
  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
end
