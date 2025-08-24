Rails.application.routes.draw do
  resources :categories, except: :show
  # Página principal
  root "products#index"

  # CRUD completo de productos (7 rutas RESTful de products)
  resources :products
  # Solo Ruta Mostrar
  # get '/products', to: 'products#index'

  # Rutas para el registro de usuarios
  namespace :authentication, path: "", as: "" do
    resources :users, only: [ :new, :create ]
    resources :sessions, only: [ :new, :create, :destroy ]
  end
end
