require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  test "Users index page NOT logged in" do
    get users_path
    assert_redirected_to new_user_session_path
  end

end
