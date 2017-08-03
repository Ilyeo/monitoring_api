class Api::AddressesController < ApplicationController
  before_action :set_user
  before_action :set_user_address, only: [:show, :update, :destroy]

  # GET /api/users/:user_id/addresses
  def index
    json_response(@user.addresses)
  end

  # GET /api/users/:user_id/addresses/:address_id
  def show
    json_response(@address)
  end

  # POST /api/users/:user_id/addresses
  def create
    @user.addresses.create!(address_params)
    json_response(@user, :created)
  end

  # PUT /api/users/:user_id/addresses/:id
  def update
    @address.update(address_params)
    head :no_content
  end

  # DELETE /api/users/:user_id/addresses/:id
  def destroy
    @address.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_address
    @address = @user.addresses.find_by!(id: params[:id]) if @user
  end

  def address_params
    params.permit(:street, :zip_code, :state, :country, :city )
  end
end
