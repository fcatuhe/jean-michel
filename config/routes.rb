Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Facebook::Messenger::Server, at: 'bot'
  devise_for :users
  root to: 'pages#home'
  get '/privacy', to: 'pages#privacy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
