class Trend < ActiveRecord::Base
  belongs_to :origin, class_name: Airport
  belongs_to :destination, class_name: Airport
  has_many :flights
end
