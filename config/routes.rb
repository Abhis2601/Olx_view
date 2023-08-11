Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resource :users do 
    get 'signin', on: :collection
    post 'login', on: :collection 
  end
  resources :categories
  resources :products do 
    get'current_user_products', on: :collection
  end
  resources :purchases do 
    get 'buy', on: :member
    get 'current_user_sold_products', on: :collection
  end

end
