Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'search' => 'home#search', as: :search

  # set route for a specific park
  get 'parks', to: 'parks#show', as: :parks

  # Set the root url
  root :to => 'home#home'
end
