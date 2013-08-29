require 'test_helper'

class InterestRatesControllerTest < ActionController::TestCase
  setup do
    @interest_rate = interest_rates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interest_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interest_rate" do
    assert_difference('InterestRate.count') do
      post :create, interest_rate: { bank_customer: @interest_rate.bank_customer, duration_from: @interest_rate.duration_from, duration_to: @interest_rate.duration_to, fixed: @interest_rate.fixed, insured: @interest_rate.insured, rate: @interest_rate.rate }
    end

    assert_redirected_to interest_rate_path(assigns(:interest_rate))
  end

  test "should show interest_rate" do
    get :show, id: @interest_rate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @interest_rate
    assert_response :success
  end

  test "should update interest_rate" do
    patch :update, id: @interest_rate, interest_rate: { bank_customer: @interest_rate.bank_customer, duration_from: @interest_rate.duration_from, duration_to: @interest_rate.duration_to, fixed: @interest_rate.fixed, insured: @interest_rate.insured, rate: @interest_rate.rate }
    assert_redirected_to interest_rate_path(assigns(:interest_rate))
  end

  test "should destroy interest_rate" do
    assert_difference('InterestRate.count', -1) do
      delete :destroy, id: @interest_rate
    end

    assert_redirected_to interest_rates_path
  end
end
