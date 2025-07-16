class UsersController < ApplicationController
  before_action :require_admin, only: [ :index ]
  before_action :set_user, only: [ :show, :edit, :update ]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order(id: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, notice: "Access denied"
    end
  end

  def user_params
    params.expect(user: [ :email, :password, :active ]).tap { _1.delete(:password) if _1[:password].blank? }
  end
end
