class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_profile, only: [:new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!
  before_action :owns_profile, :only => [:show]


  # GET /projects
  # GET /projects.json
  def index
    if is_admin?
      @projects = Project.all
    elsif 
      @projects = current_user.profile.projects
      @profile = current_user.profile
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    #can i use before action instead?
    @profile = Profile.find(params[:profile_id]) 
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = @profile.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to profile_project_path(@profile,@project), notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update    
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to profile_project_path(@profile,@project), notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
    

    def set_profile
      @profile = Profile.find(params[:profile_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :start, :prevision)
    end

    def owns_profile
      if !user_signed_in? || current_user != @project.profile.user && !is_admin?
        redirect_to new_user_session_path, :flash => { :error => "Voce nao pode modificar esse profile! Por favor faca login." }
      end
    end
end
