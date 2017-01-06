class ExerciseSetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise
  before_action :set_exercise_set, only: [:show, :edit, :update, :destroy]
  before_action :authorize_set, only: [:edit, :update, :destroy]

  def index 
    @sets = @exercise.exercise_sets.where(user: current_user).order(created_at: 'desc')
    respond_to do |format|
      format.html { render 'index', locals: { sets: @sets, exercise: @exercise } }
      format.json { render json: @sets}
    end
  end
  
  def new 
    @exercise_set = @exercise.exercise_sets.build
    respond_to do |format| 
      format.html {  }
      format.js { }
    end
  end
  
  def create
    @exercise_set = @exercise.exercise_sets.build(exercise_set_params.merge(user: current_user))
    if @exercise_set.valid? 
      @exercise_set.save 
      respond_to do |format|
        format.html { redirect_to exercise_path(@exercise) }
        format.js {}
        format.json { render json: @exercise_set, status: created, location: @exercise_set }
      end
    else 
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @exercise_set.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit 
  end 
  
  def update 
    @exercise_set.update(exercise_set_params.merge(user: current_user))
    respond_to do |format|
      format.html { redirect_to exercise_path(@exercise) }
      format.json { render json: @exercise_set.errors, status: :unprocessable_entity }
    end
  end
  
  def destroy 
    @exercise_set.destroy
    respond_to do |format| 
      format.html { redirect_to exercise_path(@exercise) }
      format.json { render json: @exercise_set }
    end
  end
  
  private 

  def set_exercise 
    @exercise ||= Exercise.find_by(id: params[:exercise_id])
    if !@exercise 
      flash[:error] = "Exercise not found."
      redirect_to exercises_path
    end
  end
  
  def set_exercise_set
    @exercise_set = ExerciseSet.find_by(id: params[:id])
    if @exercise_set.nil?
      flash[:error] = "Set not found."
      redirect_to exercise_path(@exercise)
    end
  end

  def authorize_set 
    authorize @exercise_set
  end
  
  def exercise_set_params 
    params.require(:exercise_set).permit(:quantity, :weight)
  end
end
