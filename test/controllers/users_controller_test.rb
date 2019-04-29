require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user=users(:twitter)
  end

  test "Delete Twitter details works" do
#    assert_nil @user.twitter_key
  end
end
