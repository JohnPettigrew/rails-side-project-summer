require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  test "Users index page NOT logged in" do
    get users_path
    assert_redirected_to new_user_session_path
  end

#   test "Users index page logged in" do #currently doesn't log in, so will fail until that works in tests
#     get users_path
#     assert_response :success
#     assert_template 'users/index'
#     assert_select "a[href=?]", user_path, count: 1
#   end
end
