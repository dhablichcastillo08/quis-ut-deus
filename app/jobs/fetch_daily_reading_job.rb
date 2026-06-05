class FetchDailyReadingJob < ApplicationJob
  queue_as :default

  def perform(date = Date.current)
    date = date.is_a?(String) ? Date.parse(date) : date

    existing = DailyReading.find_by(date: date)
    if existing&.liturgical_color.present?
      Rails.logger.info "[FetchDailyReadingJob] Reading for #{date} already cached, skipping."
      return
    end

    Rails.logger.info "[FetchDailyReadingJob] Fetching reading for #{date}..."
    reading = LiturgicalCalendarService.new.fetch_for_date(date)

    if reading
      Rails.logger.info "[FetchDailyReadingJob] Successfully fetched reading for #{date}: #{reading.title}"
    else
      Rails.logger.warn "[FetchDailyReadingJob] No reading returned for #{date}"
    end
  end
end
