class WorkoutsController < ApplicationController
    before_action :set_workout, only: [:show, :edit, :update, :destroy]
    
    def index 
      @workouts = Workout.all
    end
    
    def show
    end
    
    def new 
      @workout = Workout.new
    end
    
    def create 
      @workout = Workout.new(workout_params)
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
      @workout.update(workout_params)
      redirect_to workout_path(@workout)
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
    
    def workout_params 
      params.require(:workout).permit(:name)
    end
      
  
  
end
