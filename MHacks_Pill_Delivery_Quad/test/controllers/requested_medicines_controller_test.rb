require 'test_helper'

class RequestedMedicinesControllerTest < ActionController::TestCase
  setup do
    @requested_medicine = requested_medicines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requested_medicines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requested_medicine" do
    assert_difference('RequestedMedicine.count') do
      post :create, requested_medicine: { medicine_id: @requested_medicine.medicine_id, quantity: @requested_medicine.quantity, request_id: @requested_medicine.request_id }
    end

    assert_redirected_to requested_medicine_path(assigns(:requested_medicine))
  end

  test "should show requested_medicine" do
    get :show, id: @requested_medicine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requested_medicine
    assert_response :success
  end

  test "should update requested_medicine" do
    patch :update, id: @requested_medicine, requested_medicine: { medicine_id: @requested_medicine.medicine_id, quantity: @requested_medicine.quantity, request_id: @requested_medicine.request_id }
    assert_redirected_to requested_medicine_path(assigns(:requested_medicine))
  end

  test "should destroy requested_medicine" do
    assert_difference('RequestedMedicine.count', -1) do
      delete :destroy, id: @requested_medicine
    end

    assert_redirected_to requested_medicines_path
  end
end
