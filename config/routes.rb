Rails.application.routes.draw do
  root 'workouts#index'
  resources :exercises
  resources :workouts
  devise_for :users

  patch 'users/:id/toggle_admin', to: 'users#update', as: 'toggle_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
