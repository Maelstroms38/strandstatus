Rails.application.routes.draw do
  resources :pictures
  resources :activities, only: [:index]
  resources :albums

  get 'profiles/show'

devise_for :users, skip: [:sessions], :controllers => { registrations: 'registrations' }
  
  as :user do
  get "/signin" => 'devise/sessions#new', as: :new_user_session
  post "/signin" => 'devise/sessions#create', as: :user_session
  delete "/logout" => 'devise/sessions#destroy', as: :destroy_user_session
end

 devise_scope :user do
    get '/signup', to: 'devise/registrations#new', as: :signup
    get '/signin', to: 'devise/sessions#new', as: :signin
    get '/signout', to: 'devise/sessions#destroy', as: :signout
end

resources :user_friendships do
  member do 
    put :accept
    put :block
  end
end

resources :statuses
  get "strands", :to => "statuses#index", :as => :strands
  root to: 'statuses#index'

scope ":profile_name" do
resources :albums do
  resources :pictures
end
end

get '/:id', to: "profiles#show", as: 'profile'


end