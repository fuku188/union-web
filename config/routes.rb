Rails.application.routes.draw do

  root 'web#top'
  get  'signups' => 'web#signups'

  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  resources :account_activations, only: [:edit]

  resources :circles do
    resources :blogs
    resources :events
    resources :contacts
    resources :entries
    collection do
      get :search
    end
  end
end
