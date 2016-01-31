class FlightScraperJob < ActiveJob::Base
  queue_as :default

  def perform(trend)
    agent = Mechanize.new

    form = agent.get('http://www.southwest.com/flight').form 'buildItineraryForm'

    results = agent.submit(populate(form, trend))

    rows = results.search '#faresOutbound>tbody>tr'

    rows.each do |r|
      prices = r.css('.price_column .product_price')
      Flight.find_or_create_by(
          departure: Time.parse(r.css('.depart_column .bugText').text.strip.gsub(/\s+/, ' '), trend.date.beginning_of_day),
          arrival: Time.parse(r.css('.arrive_column .bugText').text.strip.gsub(/\s+/, ' '), trend.date.beginning_of_day),
          number: r.css('.flight_column .swa_text_flightNumber .bugText').text.match(/[0-9]+/)[0]
      ) do |f|
        f.trend = trend
        f.routing = r.css('.routing_column .bugText').text.gsub(/\(opens popup\)/, '').strip
        f.duration = r.css('.duration.bugText').text
        f.price_points << PricePoint.create(price: prices[2].text.gsub(/,/, '').strip, datetime: DateTime.now)
        f.save
      end
    end
  end

  def populate(form, trend)
    form.tap do |f|
      f.radiobutton_with(name: /twoWayTrip/, value: /false/).check
      f.radiobutton_with(name: /fareType/, value: /POINTS/).check

      f['originAirport'] = trend.origin.code
      f['destinationAirport'] = trend.destination.code
      f['outboundDateString'] = trend.date.strftime '%m/%d/%Y'
    end
  end

end
