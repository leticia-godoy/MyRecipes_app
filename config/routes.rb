Rails.application.routes.draw do
  
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  resources :recipes
  get '/recipes/:id(.:format)', to: 'recipes#destroy'
end
