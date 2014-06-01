Mailbox::Application.routes.draw do
  root :to => "home#index"
  resources :letters
  resources :supporters
  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  get "/contacts/gmail/callback" => "contact_import#import"
  get "/contacts/failure" => "contact_import#failure"
  get '/public/letter/:token' => 'public/letter#index', :as => :view_letter_start
  post '/public/letter/:token' => 'public/letter#send_code', :as => :send_code
  get '/public/letter/:token/enter_code' => 'public/letter#enter_code', :as => :enter_code
  get '/public/letter/:token/view' => 'public/letter#view', :as => :view_letter
end
