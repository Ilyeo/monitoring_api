class Api::AddressesController < ApplicationController
  before_action :set_user

  # GET /api/users/:user_id/addresses
  def index
    json_response(@user.addresses)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
