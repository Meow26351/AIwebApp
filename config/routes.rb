Rails.application.routes.draw do
  devise_for :agents
  #home
  root 'home#index'
  get 'home/duties'
  #tasks
  get 'task/tasks'
  get 'task/active_tasks'
  get 'task/finished_tasks'
  post 'task', to: 'task#active_tasks'
  post 'task', to: 'task#finished_tasks'
  patch 'task/active_tasks/:id/label_correct', to: 'task#label_correct', as: 'label_correct'
  patch 'task/active_tasks/:id/label_incorrect', to: 'task#label_incorrect', as: 'label_incorrect'
end
