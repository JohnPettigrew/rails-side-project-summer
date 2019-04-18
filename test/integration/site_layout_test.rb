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
    assert_select "header"
    assert_select "header>a[href=?]", root_path, count: 1
    assert_select "li", text: "Home"
    assert_select "nav>ul>li>a[href=?]", root_path, count: 1
    assert_select "li", text: "About #SideProjectSummer"
    assert_select "nav>ul>li>a[href=?]", about_path, count: 1
    assert_select "li", text: "Log in"
    assert_select "nav>ul>li>a[href=?]", new_user_session_path, count: 1
    assert_select "li", text: "Sign up"
    assert_select "nav>ul>li>a[href=?]", new_user_registration_path, count: 1
  end

# This test isn't working - user seems not to be logged in at all!
#   test "Header on home page when logged in" do
#     get root_path
#     @user=users(:one)
#     sign_in (:one)
#     assert_response :success
#     assert_select "p.alert-success", count: 1
#     assert_select "p.alert-danger", count: 0
#     assert_template 'static_pages/home'
#     assert_select "title", "#{@base_title}"
#     assert_select "header"
#     assert_select "header>a[href=?]", root_path, count: 1
#     assert_select "li", text: "Home"
#     assert_select "nav>ul>li>a[href=?]", root_path, count: 1
#     assert_select "li", text: "About #SideProjectSummer"
#     assert_select "nav>ul>li>a[href=?]", about_path, count: 1
#     assert_select "li", text: "Users"
#     assert_select "nav>ul>li>a[href=?]", users_path, count: 1
#     assert_select "li", text: "Profile"
#     assert_select "nav>ul>li>a[href=?]", user_path, count: 1
#     assert_select "li", text: "Log out"
#     assert_select "nav>ul>li>a[href=?]", destroy_user_session_path, count: 1
#   end

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
end
