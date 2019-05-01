require 'test_helper'

class AdminUserTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "#sideprojectsummer"
    @admin=users(:admin)
    @user=users(:one)
    @project=projects(:orange)
  end

  test "Can see admin users on index and profiles" do
    sign_in @admin
    get users_path
    assert_response :success
    assert_select ".user-name", title=@admin.name + " (is an admin)", count: 1
    get user_path(@admin)
    assert_response :success
    assert_select ".profile-name", title=@admin.name + " (is an admin)", count: 1
    assert_select ".user-admin", count: 1
  end

  test "Can delete users from user index" do
    sign_in @admin
    get users_path
    assert_response :success
    assert_select ".delete-user-link", count: 4
    assert_select "div.delete-user-link>a[data-method=?]", "delete", count: 4
  end

  test "Can edit other users from their profiles" do
    sign_in @admin
    get user_path(@user)
    assert_response :success
    assert_select ".profile-contact>a[href=?]", admin_edit_user_path
  end

  test "Can edit other users' projects" do
    sign_in @admin
    get project_path(@project)
    assert_response :success
    assert_select ".project-edit>a[href=?]", edit_project_path(@project), count: 2
  end
end
