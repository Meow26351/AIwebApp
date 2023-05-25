Rails.application.routes.draw do
  devise_for :agents
  #home
  root 'home#index'
  #tasks
  get 'task/tasks'
  get 'task/active_tasks'
  get 'task/finished_tasks'
  get 'task/image_page'
  get '/task/image_page/:id', to: 'task#image_page', as: 'image_page'
  post 'task', to: 'task#active_tasks'
  post 'task', to: 'task#finished_tasks'
  patch 'task/active_tasks/:id/label_correct', to: 'task#label_correct', as: 'label_correct'
  patch 'task/active_tasks/:id/label_incorrect', to: 'task#label_incorrect', as: 'label_incorrect'
  patch 'task/finished_tasks/:id/edit_task', to: 'task#edit_task', as: 'edit_task'
  #admin
  get 'admin/agents_work'
  get 'admin/analysis'
  get 'admin/show_agent/:id', to: 'admin#show_agent', as: 'show_agent'
end
