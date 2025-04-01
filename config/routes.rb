Rails.application.routes.draw do
  get "users/index"
  # Devise with JSON-only responses and custom controllers
  devise_for :users,
    defaults: { format: :json },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords"  # Optional
    },
    path: "auth"  # Avoids route conflicts (e.g., /auth/sign_in)

  # Custom user routes (avoid overlap with Devise)
  resources :users, only: [ :index, :show ], path: "auth/users"
  resources :tasks, only: [ :create ]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Optional: Root route (e.g., for docs)
  # root "home#index"
end
