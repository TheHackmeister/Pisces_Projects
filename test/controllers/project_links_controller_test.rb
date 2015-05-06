require 'test_helper'

class ProjectLinksControllerTest < ActionController::TestCase
  setup do
    @project_link = project_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_link" do
    assert_difference('ProjectLink.count') do
      post :create, project_link: { Project_id: @project_link.Project_id, name: @project_link.name, sort: @project_link.sort, url: @project_link.url }
    end

    assert_redirected_to project_link_path(assigns(:project_link))
  end

  test "should show project_link" do
    get :show, id: @project_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_link
    assert_response :success
  end

  test "should update project_link" do
    patch :update, id: @project_link, project_link: { Project_id: @project_link.Project_id, name: @project_link.name, sort: @project_link.sort, url: @project_link.url }
    assert_redirected_to project_link_path(assigns(:project_link))
  end

  test "should destroy project_link" do
    assert_difference('ProjectLink.count', -1) do
      delete :destroy, id: @project_link
    end

    assert_redirected_to project_links_path
  end
end
