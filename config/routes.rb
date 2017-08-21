Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users do
      resources :addresses do
        resources :events
      end
    end
    # resources :users, format: :json, only: [:index]
  end
end
