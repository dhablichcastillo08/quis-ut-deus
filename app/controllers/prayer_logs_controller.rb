class PrayerLogsController < ApplicationController
  before_action :set_habit

  def create
    unless @habit.completed_today?
      @habit.prayer_logs.create!(user: current_user, completed_at: Time.current)
    end

    render turbo_stream: turbo_stream.replace(
      "habit_#{@habit.id}_check",
      partial: "dashboard/habit_check",
      locals: { habit: @habit }
    )
  end

  def today
    @habit.prayer_logs
          .where("completed_at >= ?", Date.current.beginning_of_day)
          .destroy_all

    render turbo_stream: turbo_stream.replace(
      "habit_#{@habit.id}_check",
      partial: "dashboard/habit_check",
      locals: { habit: @habit }
    )
  end

  private

  def set_habit
    @habit = current_user.prayer_habits.find(params[:prayer_habit_id])
  end
end
