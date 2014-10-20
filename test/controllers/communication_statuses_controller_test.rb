require 'test_helper'

class CommunicationStatusesControllerTest < ActionController::TestCase
  setup do
    @communication_status = communication_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:communication_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create communication_status" do
    assert_difference('CommunicationStatus.count') do
      post :create, communication_status: { text: @communication_status.text, val: @communication_status.val }
    end

    assert_redirected_to communication_status_path(assigns(:communication_status))
  end

  test "should show communication_status" do
    get :show, id: @communication_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @communication_status
    assert_response :success
  end

  test "should update communication_status" do
    patch :update, id: @communication_status, communication_status: { text: @communication_status.text, val: @communication_status.val }
    assert_redirected_to communication_status_path(assigns(:communication_status))
  end

  test "should destroy communication_status" do
    assert_difference('CommunicationStatus.count', -1) do
      delete :destroy, id: @communication_status
    end

    assert_redirected_to communication_statuses_path
  end
end
