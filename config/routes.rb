Rails.application.routes.draw do
  resources :categories, except: :show
  # Página principal
  root "products#index"
  # CRUD completo de productos (7 rutas RESTful de products)
  resources :products
  # Solo Ruta Mostrar
  # get '/products', to: 'products#index'


  # Otros recursos en el futuro
  # resources :users
  # resources :orders
end
