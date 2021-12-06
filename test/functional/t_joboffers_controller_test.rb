require 'test_helper'

class TJoboffersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t_joboffers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t_joboffer" do
    assert_difference('TJoboffer.count') do
      post :create, :t_joboffer => { }
    end

    assert_redirected_to t_joboffer_path(assigns(:t_joboffer))
  end

  test "should show t_joboffer" do
    get :show, :id => t_joboffers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => t_joboffers(:one).to_param
    assert_response :success
  end

  test "should update t_joboffer" do
    put :update, :id => t_joboffers(:one).to_param, :t_joboffer => { }
    assert_redirected_to t_joboffer_path(assigns(:t_joboffer))
  end

  test "should destroy t_joboffer" do
    assert_difference('TJoboffer.count', -1) do
      delete :destroy, :id => t_joboffers(:one).to_param
    end

    assert_redirected_to t_joboffers_path
  end
end
