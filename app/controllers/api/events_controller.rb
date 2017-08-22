class Api::EventsController < ApplicationController
  before_action :set_address
  before_action :set_address_event, only: [:show]

  # GET /api/users/:user_id/addresses/:address_id/events
  def index
    json_response(@address.events)
  end

  # GET /api/users/:user_id/addresses/:address_id/events/:id
  def show
    json_response(@event)
  end

  private

  def set_address
    @address = Address.find(params[:address_id])
  end

  def set_address_event
    @event = @address.events.find_by!(id: params[:id]) if @address
  end
end
