require 'test_helper'

class JobseekersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobseekers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobseeker" do
    assert_difference('Jobseeker.count') do
      post :create, :jobseeker => { }
    end

    assert_redirected_to jobseeker_path(assigns(:jobseeker))
  end

  test "should show jobseeker" do
    get :show, :id => jobseekers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => jobseekers(:one).to_param
    assert_response :success
  end

  test "should update jobseeker" do
    put :update, :id => jobseekers(:one).to_param, :jobseeker => { }
    assert_redirected_to jobseeker_path(assigns(:jobseeker))
  end

  test "should destroy jobseeker" do
    assert_difference('Jobseeker.count', -1) do
      delete :destroy, :id => jobseekers(:one).to_param
    end

    assert_redirected_to jobseekers_path
  end
end
