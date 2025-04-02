Rails.application.routes.draw do
  get "users/index"
  devise_for :users,
    defaults: { format: :json },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords"
    },
    path: "auth"

  resources :users, only: [ :index, :show ], path: "auth/users"
  resources :tasks, only: [ :index, :show, :create, :update, :destroy ] do
    collection do
      patch :complete
    end
    member do
      patch :complete
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
