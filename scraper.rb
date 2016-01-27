require "mechanize"

agent = Mechanize.new

page = agent.get('http://www.southwest.com/flight')


form = page.form 'buildItineraryForm'

form.radiobutton_with(name: /twoWayTrip/, value: /false/).check
form.radiobutton_with(name: /fareType/, value: /POINTS/).check

form['originAirport'] = 'MDW'
form['destinationAirport'] = 'DEN'
form['outboundDateString'] = '03/02/2016'

page = agent.submit (form)

flight_rows = page.search '#faresOutbound>tbody>tr'
flights = flight_rows.collect do |r|
  prices = r.css('.price_column .product_price')
  {
      depart: r.css('.depart_column .bugText').text.strip.gsub(/\s+/, ' '),
      arrive: r.css('.arrive_column .bugText').text.strip.gsub(/\s+/, ' '),
      flightNumber: r.css('.flight_column .swa_text_flightNumber .bugText').text.match(/[0-9]/)[0],
      routing: r.css('.routing_column .bugText').text.gsub(/\(opens popup\)/, '').strip,
      duration: r.css('.duration.bugText').text,
      selectPrice: prices[0].text.strip,
      anytimePrice: prices[1].text.strip,
      getAwayPrice: prices[2].text.strip
  }
end

flights.each { |f| puts f }

# pp page.body
# puts page.body
