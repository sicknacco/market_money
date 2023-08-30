Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/markets/search', to: 'markets_search#index'
      resources :markets, only: [:index, :show] do
        get '/nearest_atms', to: 'atms#index'
        resources :vendors, only: [:index]
      end
      
      resources :vendors, only: [:show, :create, :update, :destroy]
      resources :market_vendors, only: [:create]
      delete '/market_vendors', to: 'market_vendors#destroy'
    end
  end
end
