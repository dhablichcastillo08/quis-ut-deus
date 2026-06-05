class LiturgicalCalendarService
  require "resolv"

  
  CALENDAR_API_BASE = "http://calapi.inadiutorium.cz/api/v0/en/calendars/default"
  READINGS_API_BASE = "https://cpbjr.github.io/catholic-readings-api"

  def self.fetch_today
    new.fetch_for_date(Date.current)
  end

  def fetch_for_date(date)
    existing = DailyReading.find_by(date: date)
    return existing if existing&.liturgical_color.present?

    reading_data = build_reading_data(date)
    upsert_reading(date, reading_data)
  rescue => e
    Rails.logger.error "[LiturgicalCalendarService] Error fetching #{date}: #{e.message}"
    DailyReading.find_by(date: date)
  end

  private

  def build_reading_data(date)
    calendar = fetch_calendar_data(date)
    readings = fetch_readings_data(date)
    liturgical = fetch_liturgical_calendar_data(date)

    merge_data(date, calendar, readings, liturgical)
  end

def fetch_calendar_data(date)
  host = URI(CALENDAR_API_BASE).host                       # "calapi.inadiutorium.cz"
  ipv4 = Resolv::DNS.open { |d| d.getresource(host, Resolv::DNS::Resource::IN::A).address.to_s }
  url  = "http://#{ipv4}/api/v0/en/calendars/default/#{date.year}/#{date.month}/#{date.day}"
  Rails.logger.info "[LiturgicalCalendarService] Fetching calendar: #{url} (host #{host})"

  response = HTTParty.get(url, timeout: 10, headers: { "Host" => host })
  return {} unless response.success?

  response.parsed_response
  rescue => e
    Rails.logger.warn "[LiturgicalCalendarService] Calendar API failed: #{e.message}"
    {}
end

  def fetch_readings_data(date)
    month_day = date.strftime("%m-%d")
    url = "#{READINGS_API_BASE}/readings/#{date.year}/#{month_day}.json"
    Rails.logger.info "[LiturgicalCalendarService] Fetching readings: #{url}"

    response = HTTParty.get(url, timeout: 10)
    return {} unless response.success?

    response.parsed_response
  rescue => e
    Rails.logger.warn "[LiturgicalCalendarService] Readings API failed: #{e.message}"
    {}
  end

  def fetch_liturgical_calendar_data(date)
    month_day = date.strftime("%m-%d")
    url = "#{READINGS_API_BASE}/liturgical-calendar/#{date.year}/#{month_day}.json"
    Rails.logger.info "[LiturgicalCalendarService] Fetching liturgical calendar: #{url}"

    response = HTTParty.get(url, timeout: 10)
    return {} unless response.success?

    response.parsed_response
  rescue => e
    Rails.logger.warn "[LiturgicalCalendarService] Liturgical calendar API failed: #{e.message}"
    {}
  end

  def merge_data(date, calendar, readings, liturgical)
    celebration = primary_celebration(calendar)
    liturgical_cel = liturgical["celebration"]

    color = extract_color(calendar, celebration)
    season = extract_season(calendar, readings, liturgical)

    {
      date: date,
      season: season,
      liturgical_color: color,
      title: extract_title(celebration, liturgical_cel),
      rank: celebration&.dig("rank"),
      first_reading: readings.dig("readings", "firstReading"),
      psalm: readings.dig("readings", "psalm"),
      second_reading: readings.dig("readings", "secondReading"),
      gospel: readings.dig("readings", "gospel"),
      usccb_link: readings["usccbLink"],
      celebration_name: extract_celebration_name(celebration, liturgical_cel),
      celebration_type: liturgical_cel&.dig("type"),
      celebration_description: liturgical_cel&.dig("description"),
      celebration_quote: liturgical_cel&.dig("quote"),
      saint_of_the_day: liturgical_cel&.dig("name"),
      feast_day: liturgical_cel&.dig("name")
    }
  end

  def upsert_reading(date, data)
    reading = DailyReading.find_or_initialize_by(date: date)
    reading.assign_attributes(data.compact)
    reading.save!
    reading
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "[LiturgicalCalendarService] Failed to save reading for #{date}: #{e.message}"
    nil
  end

  def primary_celebration(calendar)
    celebrations = calendar["celebrations"]
    return nil unless celebrations.is_a?(Array) && celebrations.any?

    celebrations.min_by { |c| c["rank_num"].to_f }
  end

  def extract_color(calendar, celebration)
    color = celebration&.dig("colour") || calendar["colour"]
    # Normalize "violet" to "purple" for CSS consistency
    color == "violet" ? "purple" : color
  end

  def extract_season(calendar, readings, liturgical)
    calendar["season"] || liturgical["season"] || readings["season"]
  end

  def extract_title(celebration, liturgical_cel)
    liturgical_cel&.dig("name") || celebration&.dig("title")
  end

  def extract_celebration_name(celebration, liturgical_cel)
    liturgical_cel&.dig("name") || celebration&.dig("title")
  end
end
