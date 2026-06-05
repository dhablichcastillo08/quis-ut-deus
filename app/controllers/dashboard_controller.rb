class DashboardController < ApplicationController
  def index
    @today_reading = LiturgicalCalendarService.fetch_today
    @prayer_habits = current_user.prayer_habits.where(active: true).includes(:prayer_logs)
  end
end
