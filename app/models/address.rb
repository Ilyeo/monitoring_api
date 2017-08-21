class Address < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  validates_presence_of :street, :zip_code, :state, :country, :city
end
