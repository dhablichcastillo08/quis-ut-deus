class PrayerHabitsController < ApplicationController
  before_action :set_habit, only: [:destroy]

  def index
    @prayer_habits = current_user.prayer_habits.order(created_at: :asc)
  end

  def new
    @prayer_habit = current_user.prayer_habits.build
  end

  def create
    @prayer_habit = current_user.prayer_habits.build(habit_params)
    @prayer_habit.active = true

    if @prayer_habit.save
      redirect_to prayer_habits_path, notice: "Habit added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @prayer_habit.destroy
    redirect_to prayer_habits_path, notice: "Habit removed."
  end

  private

  def set_habit
    @prayer_habit = current_user.prayer_habits.find(params[:id])
  end

  def habit_params
    params.require(:prayer_habit).permit(:name, :description, :frequency)
  end
end
