class ExercisesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]
  before_action :authorize_exercise, only: [:edit, :update, :destroy]
  
  def index 
    @exercises = Exercise.all
    # @exercises = current_user.exercises
    respond_to do |format|
      format.html 
      format.json { render json: @exercises }
    end
  end
  
  def show
    respond_to do |format|
      format.html 
      format.json { render json: @exercise }
    end
  end
  
  def new 
    @exercise = current_user.exercises.build
  end
  
  def create 
    @exercise = Exercise.new(exercise_params.merge(user: current_user))
    if current_user.add_exercise(@exercise) 
      @exercise.save 
      respond_to do |format|
        format.html { redirect_to exercises_path }
        format.json { render json: @exercise, status: created, location: @exercise }
      end
    else 
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit 
  end 
  
  def update 
    @exercise.update(exercise_params.merge(user: current_user))
    respond_to do |format|
      format.html { redirect_to exercise_path(@exercise) }
      format.json { render json: @exercise.errors, status: :unprocessable_entity }
    end
    
  end
  
  def destroy 
    
    @exercise.destroy
    respond_to do |format| 
      format.html { redirect_to exercises_path }
      format.json { render json: @exercise }
    end
  end
  
  private 
  
  def set_exercise
    @exercise = Exercise.find_by(id: params[:id])
    if @exercise.nil?
      flash[:error] = "Exercise not found."
      redirect_to exercises_path
    end
  end

  def authorize_exercise 
    authorize @exercise
  end
  
  def is_my_exercise?
    @exercise.user == current_user
  end
  
  def exercise_params 
    params.require(:exercise).permit(:name, :description)
  end
end
