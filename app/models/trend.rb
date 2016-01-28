class Trend < ActiveRecord::Base
  has_one :origin, class_name: 'Airport'
  has_one :destination, class_name: 'Airport'
end
