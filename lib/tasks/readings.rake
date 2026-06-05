namespace :readings do
  desc "Backfill daily readings for the past N days (default 30)"
  task :backfill, [:days] => :environment do |_t, args|
    days = (args[:days] || 30).to_i
    start_date = Date.current - days
    (start_date..Date.current).each do |date|
      puts "Fetching #{date}..."
      FetchDailyReadingJob.perform_now(date)   # synchronous, no worker needed
      sleep 0.5                                 # be polite to the upstream APIs
    end
    puts "Done. #{DailyReading.where.not(liturgical_color: nil).count} readings with color."
  end
end
