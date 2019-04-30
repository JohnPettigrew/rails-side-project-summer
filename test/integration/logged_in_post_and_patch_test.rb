require 'test_helper'

class LoggedInPostAndPatchTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "#sideprojectsummer"
    @user=users(:one)
    @another_user=users(:two)
    @project=projects(:orange)
  end

  # Still to be written
  test "Can create project" do
    sign_in @user
    get new_project_path(@project)
    assert_response :success
    assert_template 'projects/new'
  end

  test "Can reach edit-project page" do
    sign_in @user
    get edit_project_path(@project)
    assert_response :success
    assert_template 'projects/edit'
    assert_select "input", count: 7
    assert_select "input#project_name[type=text][value=?]", @project.name, count: 1
    assert_select "textarea#project_description", count: 1 #Can't check value for the text area, for some reason
    assert_select "input#project_source[type=url][value=?]", @project.source, count: 1
    assert_select "#project_finished[type=checkbox][value=\"?\"]", false, count: 1
    assert_select ".project-finished-field", count: 1
  end

  # Still to be written
  test "Can edit project" do
    sign_in @user
    get edit_project_path(@project)
    assert_response :success
    assert_template 'projects/edit'
  end

  test "Can reach edit-user-profile page" do
    sign_in @user
    get edit_user_registration_path(@user)
    assert_response :success
    assert_template 'devise/registrations/edit'
  end

  # Still to be written
  test "Can edit own user profile" do
    sign_in @user
    get edit_user_registration_path(@user)
    assert_response :success
    assert_template 'devise/registrations/edit'
  end
end
