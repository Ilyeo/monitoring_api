class Api::EventsController < ApplicationController
  before_action :set_address

  # GET /api/users/:user_id/addresses/:address_id/events
  def index
    json_response(@address.events)
  end

  private

  def set_address
    @address = Address.find(params[:address_id])
  end
end
