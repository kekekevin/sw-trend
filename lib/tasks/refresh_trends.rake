desc 'Add all flight trends searches to the worker queue'

task refresh_trends: :environment do
  Trend.all.each { |t| FlightScraperJob.perform_later t }
end