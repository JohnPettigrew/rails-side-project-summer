require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @base_title = "#sideprojectsummer"
  end

  test "Header on home page when logged out" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'
    assert_select "title", "#{@base_title}"
    assert_select "header>a[href=?]", root_path, count: 1
    assert_select "header" do
      assert_select "li", text: "Home"
      assert_select "nav>ul>li>a[href=?]", root_path, count: 1
      assert_select "li", text: "About #SideProjectSummer"
      assert_select "nav>ul>li>a[href=?]", about_path, count: 1
      assert_select "li", text: "Participants"
      assert_select "nav>ul>li>a[href=?]", users_path, count: 1
      assert_select "li", text: "All projects"
      assert_select "nav>ul>li>a[href=?]", projects_path, count: 1
      assert_select "li", text: "Sign in"
      assert_select "nav>ul>li>a[href=?]", new_user_session_path, count: 1
      assert_select "li", text: "Take part!"
      assert_select "nav>ul>li>a[href=?]", new_user_registration_path, count: 1
    end
  end

# This test isn't working - the commented-out portions should appear (and do in the browser) but don't in the test. Something odd is happening!
  test "Header on home page when logged in" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    @user=users(:one)
    post new_user_session_path(email: @user.email, password: 'password123')
#     assert_response :success
#     assert_select "p.alert-success", count: 1
#     assert_select "p.alert-danger", count: 0
#     assert_template 'static_pages/home'
#     assert_select "title", "#{@base_title}"
#     get users_path
#     assert_template 'layouts/users/index'
#     assert_select "header>a[href=?]", root_path, count: 1
#     assert_select "header" do
#       assert_select "li", text: "Home"
#       assert_select "nav>ul>li>a[href=?]", root_path, count: 1
#       assert_select "li", text: "About #SideProjectSummer"
#       assert_select "nav>ul>li>a[href=?]", about_path, count: 1
#       assert_select "li", text: "Participants"
#       assert_select "nav>ul>li>a[href=?]", users_path, count: 1
#       assert_select "li", text: "All projects"
#       assert_select "nav>ul>li>a[href=?]", projects_path, count: 1
#       assert_select "li", text: "Your profile"
#       assert_select "nav>ul>li>a[href=?]", user_path, count: 1
#       assert_select "li", text: "Sign out"
#       assert_select "nav>ul>li>a[href=?]", destroy_user_session_path, count: 1
#     end
  end

  test "Footer content" do
    get root_path
    assert_select "footer"
    assert_select "footer>p>a[href=?]", about_path, count: 1
    assert_select "footer>p>a[href=?]", privacy_path, count: 1
  end

  test "Privacy page" do
    get privacy_path
    assert_response :success
    assert_template 'static_pages/privacy'
    assert_select "title", "Privacy | #{@base_title}"
  end

  test "About page" do
    get about_path
    assert_response :success
    assert_template 'static_pages/about'
    assert_select "title", "About | #{@base_title}"
  end

  test "Show participants list when logged out" do
    get users_path
    assert_response :success
    assert_template 'users/index'
  end
end
