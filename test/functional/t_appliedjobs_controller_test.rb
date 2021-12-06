require 'test_helper'

class TAppliedjobsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t_appliedjobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t_appliedjob" do
    assert_difference('TAppliedjob.count') do
      post :create, :t_appliedjob => { }
    end

    assert_redirected_to t_appliedjob_path(assigns(:t_appliedjob))
  end

  test "should show t_appliedjob" do
    get :show, :id => t_appliedjobs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => t_appliedjobs(:one).to_param
    assert_response :success
  end

  test "should update t_appliedjob" do
    put :update, :id => t_appliedjobs(:one).to_param, :t_appliedjob => { }
    assert_redirected_to t_appliedjob_path(assigns(:t_appliedjob))
  end

  test "should destroy t_appliedjob" do
    assert_difference('TAppliedjob.count', -1) do
      delete :destroy, :id => t_appliedjobs(:one).to_param
    end

    assert_redirected_to t_appliedjobs_path
  end
end
