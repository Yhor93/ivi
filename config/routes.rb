Rails.application.routes.draw do
  # Página principal
  root "products#index"

  # Autenticación (registro y login)
  namespace :authentication, path: "", as: "" do
    resources :users, only: [ :new, :create ],
                      path: "/register",
                      path_names: { new: "/" }

    resources :sessions, only: [ :new, :create, :destroy ],
                        path: "/login",
                        path_names: { new: "/" }
  end

  # Perfil de usuario (por username en lugar de id)
  resources :users, only: :show, path: "/user", param: :username

  # Categorías (sin show)
  resources :categories, except: :show

  # Favoritos
  resources :products do
  post :toggle_favorite, on: :member
  end

  # CRUD de productos
  resources :products
end
