class Api::UsersController < ApplicationController

  def index
    @users = User.all
    json_response(@users)
    # render json: '', status: 200
  end

end
