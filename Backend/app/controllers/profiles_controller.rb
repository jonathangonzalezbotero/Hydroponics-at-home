class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update]

  def index
  end

  def new
    @profiles = Profile.new
  end

  def create
    @profiles = Profile.new(profile_params)

    if @profiles.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def profile_params
    params.require(:profiles).permit(:id_person, :type_ID, :first_name, :last_name, :idRol)
  end

  def find_profile
    @profiles = Profile.find(params[:id])
  end
end
