require 'test_helper'

class CoptersControllerTest < ActionController::TestCase
  setup do
    @copter = copters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:copters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create copter" do
    assert_difference('Copter.count') do
      post :create, copter: { available: @copter.available, hospital_id: @copter.hospital_id, last_latitude: @copter.last_latitude, last_longitude: @copter.last_longitude, name: @copter.name, type: @copter.type }
    end

    assert_redirected_to copter_path(assigns(:copter))
  end

  test "should show copter" do
    get :show, id: @copter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @copter
    assert_response :success
  end

  test "should update copter" do
    patch :update, id: @copter, copter: { available: @copter.available, hospital_id: @copter.hospital_id, last_latitude: @copter.last_latitude, last_longitude: @copter.last_longitude, name: @copter.name, type: @copter.type }
    assert_redirected_to copter_path(assigns(:copter))
  end

  test "should destroy copter" do
    assert_difference('Copter.count', -1) do
      delete :destroy, id: @copter
    end

    assert_redirected_to copters_path
  end
end
