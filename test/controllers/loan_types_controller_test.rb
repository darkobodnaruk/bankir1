require 'test_helper'

class LoanTypesControllerTest < ActionController::TestCase
  setup do
    @loan_type = loan_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loan_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan_type" do
    assert_difference('LoanType.count') do
      post :create, loan_type: { name: @loan_type.name }
    end

    assert_redirected_to loan_type_path(assigns(:loan_type))
  end

  test "should show loan_type" do
    get :show, id: @loan_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loan_type
    assert_response :success
  end

  test "should update loan_type" do
    patch :update, id: @loan_type, loan_type: { name: @loan_type.name }
    assert_redirected_to loan_type_path(assigns(:loan_type))
  end

  test "should destroy loan_type" do
    assert_difference('LoanType.count', -1) do
      delete :destroy, id: @loan_type
    end

    assert_redirected_to loan_types_path
  end
end
