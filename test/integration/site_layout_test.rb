require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "#sideprojectsummer"
  end

  test "Header content on home page" do
    get root_path
    assert_response :success
    assert_template 'static_pages/home'
    assert_select "title", "#{@base_title}"
    assert_select "header"
    assert_select "header>a[href=?]", root_path, count: 1
    assert_select "nav>ul>li>a[href=?]", root_path, count: 1
    assert_select "nav>ul>li>a[href=?]", about_path, count: 1
    assert_select "li", text: "Home"
    assert_select "li", text: "About #SideProjectSummer"
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
end
