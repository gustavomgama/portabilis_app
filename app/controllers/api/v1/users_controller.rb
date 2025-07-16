class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { id: @user.id, email: @user.email, active: @user.active }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: { id: @user.id, email: @user.email, active: @user.active }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :email, :password, :password_confirmation, :active ])
  end
end
