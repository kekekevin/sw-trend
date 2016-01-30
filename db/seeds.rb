# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

airports = Airport.create([
                              {code: 'SAT', description: 'San Antonio, TX'},
                              {code: 'MDW', description: 'Chicago Midway'},
                              {code: 'PDX', description: 'Portland, OR'}
                          ])
trends = Trend.create([
                          { origin: airports[1], destination: airports[0], date: Date.new(2016, 4, 29) },
                          { origin: airports[0], destination: airports[1], date: Date.new(2016, 5, 2) }

                      ])