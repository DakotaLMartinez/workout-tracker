class WorkoutsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
    before_action :set_workout, only: [:show, :edit, :update, :destroy]
    
    def index 
      @workouts = Workout.all
    end
    
    def show
    end
    
    def new 
      @workout = current_user.workouts.build
    end
    
    def create 
      @workout = current_user.workouts.build(workout_params)
      if @workout.valid? 
        @workout.save 
        redirect_to workouts_path
      else 
        render :new
      end
    end
    
    def edit 
    end 
    
    def update 
      if is_my_workout?
        @workout.update(workout_params.merge(user: current_user))
        redirect_to workout_path(@workout)  
      end
    end
    
    def destroy 
      @workout.destroy
      redirect_to workouts_path
    end
    
    private 
    
    def set_workout
      @workout = Workout.find_by(id: params[:id])
      if @workout.nil?
        flash[:error] = "Workout not found."
        redirect_to workouts_path
      end
    end

    def is_my_workout?
      current_user.workouts.find_by(id: params[:id])
    end
    
    def workout_params 
      params.require(:workout).permit(:name)
    end
      
  
  
end
