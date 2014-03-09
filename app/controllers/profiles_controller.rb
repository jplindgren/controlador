class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:index, :new, :create, :edit, :update, :destroy ]
  before_filter :owns_profile, :only => [:edit, :update, :destroy]
  before_filter :already_has_profile, :only => [:new]

  # GET /Profiles
  # GET /Profiles.json
  def index
    if is_admin?
      @profiles = Profile.all
    elsif user_signed_in?
      redirect_to current_user.profile
    else
      redirect_to :back, :flash => { :error => "Voce nao pode acessar essa area sem estar logado!" }
    end    
  end

  # GET /Profiles/1
  # GET /Profiles/1.json
  def show
  end

  # GET /Profiles/new
  def new
    @profile = Profile.new
    @profile.set_email(current_user.email)
  end

  # GET /Profiles/1/edit
  def edit
  end

  # POST /Profiles
  # POST /Profiles.json
  def create    
    current_user.become_profile(profile_params)
    @profile = current_user.profile

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Profiles/1
  # PATCH/PUT /Profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Profiles/1
  # DELETE /Profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :ok }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :email)
    end

    def already_has_profile
      if user_signed_in? && current_user.already_has_profile?
        redirect_to profile_path, :flash => { :error => "Voce nao ja possui um profile cadastrado!" }
      end
    end

    def owns_profile
      if !user_signed_in? || current_user != @profile.user
        redirect_to profile_path, :flash => { :error => "Voce nao pode modificar esse profile!" }
      end
    end
end
