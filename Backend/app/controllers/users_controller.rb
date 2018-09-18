class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:id_person, :type_ID, :first_name, :last_name, :email, :username, :password, :idRol)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
