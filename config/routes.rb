Rails.application.routes.draw do
  post '/search', to: 'home#search'
  get '/', to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
