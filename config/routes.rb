Chadz::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {:registrations => "registrations"}  
  
  resources :authentications

  get 'profile/edit' => 'user_infos#edit'

  resources :user_infos, :only => [:index, :edit, :update], :path => 'profile'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => 'welcome#index'

  post 'messages/:id' => 'messages#destroy'

  put 'messages/:id/:fav' => 'messages#update'

  resources :messages, :only => [:index, :create, :update, :destroy]

  get 'messagebox/customize/' => 'messageboxes#customize'

  post 'messagebox/:process/:messagebox/:user' => 'messageboxes#ban'

  post 'messagebox/settings' => 'messageboxes#settings'

  post 'messagebox/profile' => 'messageboxes#profile'

  post 'messagebox/user/:name' => 'messageboxes#userprofile'
  
  resources :messageboxes, :except => [:new], :path => 'messagebox'

  get "home" => "home#index"

  get 'connections' => "connection#index"

  get 'connections/banned' => "connection#banned"

  get 'connections/:id' => "connection#poster"

  delete 'connections/:id' => "connection#destroy"

  get 'color' => "messageboxes#customize"

  get 'messagebox_attribute' => "messageboxes#customize"

  put 'color.:id' => "messageboxes#savecss"

  put 'messagebox_attribute.:id' => "messageboxes#savecss"
end
