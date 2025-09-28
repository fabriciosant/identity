Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Rotas de autenticação
      post "/auth/signup", to: "auth/registrations#create"
      post "/auth/login", to: "auth/sessions#create"
      delete "/auth/logout", to: "auth/sessions#destroy"

      # Rotas protegidas
      resources :users, only: [ :show, :update, :destroy ]
    end
  end
end
