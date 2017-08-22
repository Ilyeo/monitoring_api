class Api::EventsController < ApplicationController
  before_action :set_address
  before_action :set_address_event, only: [:show, :update, :destroy]

  # GET /api/users/:user_id/addresses/:address_id/events
  def index
    json_response(@address.events)
  end

  # GET /api/users/:user_id/addresses/:address_id/events/:id
  def show
    json_response(@event)
  end

  # POST /api/users/:user_id/addresses/:address_id/events
  def create
    @address.events.create!(event_params)
    json_response(@address, :created)
  end

  # PUT /api/users/:user_id/addresses/:address_id/events/:id
  def update
    @event.update(event_params)
    head :no_content
  end

  # DELETE /api/users/:user_id/addresses/:address_id/events/:id
  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_address
    @address = Address.find(params[:address_id])
  end

  def set_address_event
    @event = @address.events.find_by!(id: params[:id]) if @address
  end

  def event_params
    params.permit(:zone_code, :zone_description, :event_type)
  end
end
