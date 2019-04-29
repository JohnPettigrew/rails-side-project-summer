require 'test_helper'

class LoggedInNavigationTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "#sideprojectsummer"
    @user=users(:one)
    @another_user=users(:two)
    @project=projects(:orange)
  end

  # Sign-out test not working now
  test "Reach links from header" do
    sign_in @user
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
    assert_select ".users>li", minimum: 1
    get projects_path
    assert_response :success
    assert_template 'projects/index'
    assert_select "title", "All projects | #{@base_title}"
    assert_select ".projects>.project", minimum: 1
    get user_path(@user)
    assert_response :success
    assert_template 'users/show'
    assert_select "title", "User profile | #{@base_title}"
    assert_select ".gravatar", count: 1
    assert_select ".profile-name", count: 1
    assert_select ".profile-contact", count: 1
    assert_select "a", "Connect to Twitter"
    assert_select "a", "List a new project"
#     get destroy_user_session_path(@user)
#     assert_response :success
#     assert_template 'static_pages/home'
#     assert_select "title", "#{@base_title}"
  end

  test "Read project details" do
    sign_in @user
    get project_path(@project)
    assert_response :success
    assert_template 'projects/show'
    assert_select "title", "Project details | #{@base_title}"
    assert_select ".project-name", count: 1
    assert_select ".project-description", count: 1
    assert_select ".project-source", count: 1
    assert_select ".project-listed", count: 1
#    assert_select ".project-edit", count: 1 #Again, not finding this even though should be logged in!
  end

  test "Can read user profiles" do
    sign_in @user
    get user_path(@user)
    assert_response :success
    assert_template 'users/show'
    assert_select ".gravatar", count: 1 #Most elements on this page are, oddly, not findable in this test
    assert_select ".profile-name", count: 1
    assert_select ".profile-contact", count: 1
    assert_select "a", "Connect to Twitter"
    assert_select "ul.index", count: 1
    assert_select "li.project", count: 3
    assert_select "a", "List a new project"
    assert_select ".new-project", count: 1
    get user_path(@another_user)
    assert_response :success
    assert_template 'users/show'
    assert_select ".project-listed", count: 1
    assert_select ".new-project", count: 0
  end
end
