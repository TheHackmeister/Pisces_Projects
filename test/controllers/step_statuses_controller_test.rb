require 'test_helper'

class StepStatusesControllerTest < ActionController::TestCase
  setup do
    @step_status = step_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:step_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create step_status" do
    assert_difference('StepStatus.count') do
      post :create, step_status: { text: @step_status.text, val: @step_status.val }
    end

    assert_redirected_to step_status_path(assigns(:step_status))
  end

  test "should show step_status" do
    get :show, id: @step_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @step_status
    assert_response :success
  end

  test "should update step_status" do
    patch :update, id: @step_status, step_status: { text: @step_status.text, val: @step_status.val }
    assert_redirected_to step_status_path(assigns(:step_status))
  end

  test "should destroy step_status" do
    assert_difference('StepStatus.count', -1) do
      delete :destroy, id: @step_status
    end

    assert_redirected_to step_statuses_path
  end
end
