Lifecraft::Application.routes.draw do
  root :to => 'welcome#index'

  # Welcome
  match '_about' => 'welcome#_about', :as => 'about'

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
  match 'api/login'     => 'api/user_sessions#create',  :as => :api_login
  match 'api/logout'    => 'api/user_sessions#destroy', :as => :api_logout
  match 'api/signup'    => 'api/users#create',          :as => :api_signup
  match 'api/quest/current' => 'api/quests#current',    :as => :api_quest_current
  match 'api/quest/complete' => 'api/quests#complete_quest',
    :as => :'api_quest_complete'
  match 'api/quest/new' => 'api/quests#new',            :as => :api_quest_new
  match 'api/quest/:id' => 'api/quests#show',           :as => :api_quest_id

  match 'api/activity/:id' => 'api/activities#show',
    :as => :api_activity_id
  match 'api/activity/find/:date' => 'api/activities#find',
    :as => :api_activity_find
end
