class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  def index
    @users = User.all
    json_response(@users)
    # render json: '', status: 200
  end

  # GET /users/:id
  def show
    json_response(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
