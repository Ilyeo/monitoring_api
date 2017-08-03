class Api::AddressesController < ApplicationController
  before_action :set_user
  before_action :set_user_address, only: [:show]

  # GET /api/users/:user_id/addresses
  def index
    json_response(@user.addresses)
  end

  # GET /api/users/:user_id/addresses/:address_id
  def show
    json_response(@address)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_address
    @address = @user.addresses.find_by!(id: params[:id]) if @user
  end

end
