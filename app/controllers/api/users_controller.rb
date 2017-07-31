class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /api/users
  def index
    @users = User.all
    json_response(@users)
    # render json: '', status: 200
  end

  # GET /api/users/:id
  def show
    json_response(@user)
  end

  # POST /api/users
  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  # PUT /api/users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /api/users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :mobile_no)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
