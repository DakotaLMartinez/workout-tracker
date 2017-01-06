Rails.application.routes.draw do
  devise_for :users
  root 'workouts#index'
  resources :workouts 

  resources :exercises do 
    resources :exercise_sets, as: 'sets'
        resources :workout_exercises, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
