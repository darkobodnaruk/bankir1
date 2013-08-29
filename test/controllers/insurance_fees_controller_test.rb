require 'test_helper'

class InsuranceFeesControllerTest < ActionController::TestCase
  setup do
    @insurance_fee = insurance_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insurance_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insurance_fee" do
    assert_difference('InsuranceFee.count') do
      post :create, insurance_fee: { duration_from: @insurance_fee.duration_from, duration_to: @insurance_fee.duration_to, percentual: @insurance_fee.percentual }
    end

    assert_redirected_to insurance_fee_path(assigns(:insurance_fee))
  end

  test "should show insurance_fee" do
    get :show, id: @insurance_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insurance_fee
    assert_response :success
  end

  test "should update insurance_fee" do
    patch :update, id: @insurance_fee, insurance_fee: { duration_from: @insurance_fee.duration_from, duration_to: @insurance_fee.duration_to, percentual: @insurance_fee.percentual }
    assert_redirected_to insurance_fee_path(assigns(:insurance_fee))
  end

  test "should destroy insurance_fee" do
    assert_difference('InsuranceFee.count', -1) do
      delete :destroy, id: @insurance_fee
    end

    assert_redirected_to insurance_fees_path
  end
end
