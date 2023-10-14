Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'recetas' => 'receta#recetas'
  get 'make' => 'receta#make_receta'
  get 'pedidos' => 'receta#pedidos'
end
