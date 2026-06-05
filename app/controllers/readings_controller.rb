class ReadingsController < ApplicationController
  def show
    date = parse_date(params[:date])
    @reading = DailyReading.find_by(date: date) || LiturgicalCalendarService.new.fetch_for_date(date)
    @date = date
  end

  private

  def parse_date(param)
    return Date.current if param.blank? || param == "today"
    Date.parse(param)
  rescue ArgumentError
    Date.current
  end
end
