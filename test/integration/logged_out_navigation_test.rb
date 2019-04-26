require 'test_helper'

class LoggedOutNavigationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @base_title = "#sideprojectsummer"
  end

  test "Reach links from header" do
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
    get new_user_registration_path
    assert_response :success
    assert_template 'devise/registrations/new'
    assert_select "title", "Take part! | #{@base_title}"
  end

  test "Read project details" do
    get project_path(Project.first.id)
    assert_response :success
    assert_template 'projects/show'
    assert_select "title", "Project details | #{@base_title}"
    assert_select ".project-listed", count: 1
    assert_select ".project-edit", count: 0
  end

  test "Cannot read user profiles" do
    get user_path(:one)
    assert_response :redirect
  end
end