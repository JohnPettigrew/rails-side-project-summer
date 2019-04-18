require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  test "Users index page NOT logged in" do
    get users_path
    assert_redirected_to new_user_session_path
  end

#   Currently can't log in, so not worth working on until that process works in tests
#   test "Users index page logged in" do
#     get users_path
#     assert_response :success
#     assert_template 'layouts/users/index'
#     assert_select "a[href=?]", user_path, count: 1
#   end
end
