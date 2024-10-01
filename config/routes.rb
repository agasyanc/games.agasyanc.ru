Rails.application.routes.draw do
  get 'target', to: 'target#index'
  get 'target/:code', to: 'target#game', as: 'target_game'
  post 'target', to: 'target#create'
  get 'switcher', to: 'switcher#index'
  post 'switcher', to: 'switcher#index'

  root 'home#index'
  get '/privacy', to: 'home#privacy', as: 'privacy'
  get '/terms', to: 'home#terms', as: 'terms'
  post '/', to:  'home#index'

  devise_for :players, controllers: { omniauth_callbacks: 'players/omniauth_callbacks' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount ActionCable.server => '/cable'

end
