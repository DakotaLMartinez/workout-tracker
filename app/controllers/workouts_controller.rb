class WorkoutsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  before_action :authorize_workout, only: [:show, :edit, :update, :destroy]
  
  def index 
    # @workouts = Workout.all
    @workouts = []
    @workouts = policy_scope(Workout) if current_user
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
    @workout.update(workout_params)
    respond_to do |format|
      format.html { redirect_to workout_path(@workout) }
      format.json { render json: @workout }
    end
  end
  
  def destroy 
    @workout.destroy
    respond_to do |format| 
      format.html { redirect_to workouts_path, notice: 'Workout successfully deleted' }
      format.json { render json: @workout }
    end
  end
  
  private 
  
  def set_workout
    @workout = current_user.workouts.find_by(id: params[:id])
    if @workout.nil?
      flash[:error] = "Workout not found."
      redirect_to workouts_path
    end
  end

  def authorize_workout 
    authorize @workout
  end
  
  def workout_params 
    params.require(:workout).permit(:name, exercise_ids: [])
  end
end