class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def create
    if User.create(user_params)
      flash[:notice] = I18n.t('users.create.success')
    else
      flash[:alert] = I18n.t('users.create.fail')
    end
    redirect_to users_path
  end

  def destroy
    if @user.destroy
      flash[:notice] = I18n.t('users.delete.success')
    else
      flash[:alert] = I18n.t('users.delete.fail')
    end
    redirect_to users_path
  end

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      flash[:notice] = I18n.t('users.update.success')
    else
      flash[:alert] = I18n.t('users.update.fail')
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:address, :email, :full_name, :phone_number)
  end

  def set_user
    @user = User.find(params[:id])
  end

end