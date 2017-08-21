class Event < ApplicationRecord
  belongs_to :address

  validates_presence_of :zone_code, :zone_description, :event_type
end
