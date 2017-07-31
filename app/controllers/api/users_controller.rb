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

  # POST /users
  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :mobile_no)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
