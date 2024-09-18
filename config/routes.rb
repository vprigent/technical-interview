Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "shortened_urls#new"

  resources :shortened_urls, only: [:new, :create, :show]

  get ":id", to: "shortened_urls#show"

end
