require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)    
    sign_in @profile.user
  end

  test "should get index redirected to show when admin user" do
    get :index
    assert_redirected_to profile_path(@profile) 
  end

  test "shoul get index when admin" do
    sign_in users(:admin)
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    sign_in users(:without_profile)
    get :new
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { email: @profile.email, name: @profile.name }
    end

    assert_redirected_to profile_path(assigns(:profile))
    assert_equal 'Profile was successfully created.', flash[:notice]
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profile" do
    patch :update, id: @profile, profile: { email: @profile.email, name: @profile.name }
    assert_redirected_to profile_path(assigns(:profile))
    assert_equal 'Profile was successfully updated.', flash[:notice]
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_redirected_to profiles_path
  end
end
