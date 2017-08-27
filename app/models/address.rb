class Address < ApplicationRecord
  belongs_to :user

  validates_presence_of :street, :zip_code, :state, :country, :city
end
