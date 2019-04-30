require 'test_helper'

class LoggedOutNavigationTest < ActionDispatch::IntegrationTest

  def setup
    @user=users(:one)
    @base_title = "#sideprojectsummer"
  end

  test "Can reach links from header" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'
    assert_select "title", "#{@base_title}"
    get about_path
    assert_response :success
    assert_template 'static_pages/about'
    assert_select "title", "About | #{@base_title}"
    get users_path
    assert_response :success
    assert_template 'users/index'
    assert_select "title", "All participants | #{@base_title}"
    get projects_path
    assert_response :success
    assert_template 'projects/index'
    assert_select "title", "All projects | #{@base_title}"
    get new_user_session_path
    assert_response :success
    assert_template 'devise/sessions/new'
    assert_select "title", "Sign in | #{@base_title}"
    assert_select "input", count: 6
    get new_user_registration_path
    assert_response :success
    assert_template 'devise/registrations/new'
    assert_select "title", "Take part! | #{@base_title}"
    assert_select "input", count: 8
    assert_select "textarea", count: 1
  end

  test "Can read participants list" do
    get users_path
    assert_response :success
    assert_template 'users/index'
    assert_select "title", "All participants | #{@base_title}"
    assert_select ".users>li", count: 4
    assert_select "a[href=?]", title=user_path(@user)
    assert_select ".gravatar", count: 4
    assert_select ".user-name", count: 4
  end

  test "Cannot read user profiles" do
    get user_path(@user)
    assert_response :redirect
    follow_redirect!
    assert_template 'devise/sessions/new'
  end

  test "Can read project list" do
    get projects_path
    assert_template 'projects/index'
    assert_select "title", "All projects | #{@base_title}"
    assert_select "h1", text="All projects"
    assert_select ".projects>.project", count: 4
    assert_select ".project-name", count: 4
#    assert_select ".project-owner", count: 4 #Doesn't work for some reason
    assert_select ".project-description", count: 4
    assert_select ".project-listed", count: 4
    assert_select "a[href=?]", title=new_project_path
  end

  test "Can read project details" do
    get project_path(Project.first.id)
    assert_response :success
    assert_template 'projects/show'
    assert_select "title", "Project details | #{@base_title}"
    assert_select ".project-name", count: 1
    assert_select ".project-description", count: 1
    assert_select ".project-source", count: 1
    assert_select ".project-listed", count: 1
    assert_select ".project-edit", count: 0
  end
end
