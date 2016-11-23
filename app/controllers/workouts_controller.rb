class WorkoutsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :update, :destroy]
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  
  def index 
    # @workouts = Workout.all
    @workouts = current_user.workouts
    respond_to do |format|
      format.html 
      format.json { render json: @workouts}
    end
  end
  
  def show
    respond_to do |format|
      format.html 
      format.json { render json: @workout}
    end
  end
  
  def new 
    @workout = current_user.workouts.build
  end
  
  def create 
    @workout = current_user.workouts.build(workout_params)
    if @workout.valid? 
      @workout.save 
      respond_to do |format|
        format.html { redirect_to workouts_path }
        format.json { render json: @workout, status: created, location: @workout }
      end
    else 
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit 
  end 
  
  def update 
    if is_my_workout?
      @workout.update(workout_params.merge(user: current_user))
      respond_to do |format|
        format.html { redirect_to workout_path(@workout) }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    else 
      @workout.errors.add(:user, "can't edit other user's workouts.")
      respond_to do |format|
        format.html {
          flash.alert = "cannot edit other user's workouts" 
          render :edit 
        }
        format.json { render json: @workout.errors, status: :unauthorized}
      end
    end
  end
  
  def destroy 
    if is_my_workout?
      @workout.destroy
      respond_to do |format| 
        format.html { redirect_to workouts_path }
        format.json { render json: @workout }
      end
    else 
      @workout.errors.add(:unauthorized, "- cannot delete other user's workouts")
      respond_to do |format|
        format.html { 
          flash.alert = "cannot delete other user's workouts" 
          render :show  
        }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
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