require 'test_helper'

class ReferenceRatesControllerTest < ActionController::TestCase
  setup do
    @reference_rate = reference_rates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reference_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reference_rate" do
    assert_difference('ReferenceRate.count') do
      post :create, reference_rate: { name: @reference_rate.name, rate: @reference_rate.rate }
    end

    assert_redirected_to reference_rate_path(assigns(:reference_rate))
  end

  test "should show reference_rate" do
    get :show, id: @reference_rate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reference_rate
    assert_response :success
  end

  test "should update reference_rate" do
    patch :update, id: @reference_rate, reference_rate: { name: @reference_rate.name, rate: @reference_rate.rate }
    assert_redirected_to reference_rate_path(assigns(:reference_rate))
  end

  test "should destroy reference_rate" do
    assert_difference('ReferenceRate.count', -1) do
      delete :destroy, id: @reference_rate
    end

    assert_redirected_to reference_rates_path
  end
end
