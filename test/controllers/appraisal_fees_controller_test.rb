require 'test_helper'

class AppraisalFeesControllerTest < ActionController::TestCase
  setup do
    @appraisal_fee = appraisal_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appraisal_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appraisal_fee" do
    assert_difference('AppraisalFee.count') do
      post :create, appraisal_fee: { duration_from: @appraisal_fee.duration_from, duration_to: @appraisal_fee.duration_to, fixed_max: @appraisal_fee.fixed_max, fixed_min: @appraisal_fee.fixed_min, percentual: @appraisal_fee.percentual }
    end

    assert_redirected_to appraisal_fee_path(assigns(:appraisal_fee))
  end

  test "should show appraisal_fee" do
    get :show, id: @appraisal_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appraisal_fee
    assert_response :success
  end

  test "should update appraisal_fee" do
    patch :update, id: @appraisal_fee, appraisal_fee: { duration_from: @appraisal_fee.duration_from, duration_to: @appraisal_fee.duration_to, fixed_max: @appraisal_fee.fixed_max, fixed_min: @appraisal_fee.fixed_min, percentual: @appraisal_fee.percentual }
    assert_redirected_to appraisal_fee_path(assigns(:appraisal_fee))
  end

  test "should destroy appraisal_fee" do
    assert_difference('AppraisalFee.count', -1) do
      delete :destroy, id: @appraisal_fee
    end

    assert_redirected_to appraisal_fees_path
  end
end
