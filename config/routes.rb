Rails.application.routes.draw do
  devise_for :agents
  #home
  root 'home#index'
  get 'home/duties'
  #tasks
  get 'task/tasks'
  get 'task/active_tasks'
  get 'task/finished_tasks'
  get 'home/upload_image', to: 'home#create'
  post 'task', to: 'task#active_tasks'
  post 'home/upload_image', to: 'home#create'
end
