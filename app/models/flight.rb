class Flight < ActiveRecord::Base
  belongs_to :trend
  has_many :price_points
end
