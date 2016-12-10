Rails.application.routes.draw do
  root 'home#index'

  resources :users do
    member do
      get 'profile'
      get 'matches'
    end
  end

  get 'auth/facebook/callback',  to: "sessions#create"
  match 'sign_out', to: 'sessions#destroy', via: :delete

  post 'create_friendships' => 'friendships#create'
  delete 'destroy_friendships' => 'friendships#destroy'

  get 'matches/get_email' => "users#get_email"
end
