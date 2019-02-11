module Mappable
  extend ActiveSupport::Concern

  included do
    acts_as_mappable default_units: :miles,
                     default_formula: :sphere,
                     distance_field_name: :distance,
                     lat_column_name: :lat,
                     lng_column_name: :lng
  end

  def distance_from_postcode(postcode)
    location_from_postcode(postcode).distance_to(self)
  end

  def location_from_postcode(postcode)
    Geokit::Geocoders::GoogleGeocoder.geocode postcode
  end

  module ClassMethods
    def within_distance_from_postcode(distance, postcode)
      select { |x| x.distance_from_postcode(postcode).to_f <= distance.to_f }
    end
  end
end
