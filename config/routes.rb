Rails.application.routes.draw do
  devise_for :users
  root 'workouts#index'
  resources :workouts
  resources :exercises do 
    resources :exercise_sets
  end

  patch 'users/:id/toggle_admin', to: 'users#update', as: 'toggle_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
