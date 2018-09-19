class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :update]

  def index
  end

  def new
    @profile = current_user.profiles.build
  end

  def create
    @profile = current_user.profiles.build(profile_params)

    if @profile.save
      redirect_to profiles_path
    else
      render 'new'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:id_person, :type_ID, :first_name, :last_name, :id_role)
  end

  def find_profile
    @profiles = Profile.find(params[:id_person])
  end
end
