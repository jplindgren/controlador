require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @profile = profiles(:one)
    sign_in users(:normal)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new, profile_id: @profile
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, profile_id: @profile, project: { description: @project.description, name: @project.name, prevision: @project.prevision, start: @project.start }
    end

    assert_redirected_to profile_project_path(@profile.id, assigns(:project))
  end

  test "should show project" do
    get :show, profile_id: @profile, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, profile_id: @profile, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, profile_id: @project.profile, id: @project, project: { description: @project.description, name: @project.name, prevision: @project.prevision, start: @project.start, profile_id: @project.profile.id } 
    assert_redirected_to profile_project_path(@profile.id, assigns(:project))
  end

  #test "should destroy project" do
   # assert_difference('Project.count', -1) do
    #  delete :destroy, :id => @project
   # end

   # assert_redirected_to profile_project_path(@profile)
  #end
end
