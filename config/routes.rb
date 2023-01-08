Rails.application.routes.draw do
  devise_for :agents
  root 'home#index'
  get 'home/duties'
end
