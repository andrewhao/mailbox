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
  get "/contacts/approve" => "contact_import#approve"
  get "/contacts/reject" => "contact_import#reject"
end
