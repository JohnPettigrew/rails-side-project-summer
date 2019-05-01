require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @twitter=users(:twitter)
    @admin=users(:admin)
    @user=users(:one)
  end

  test "admin_destroy works" do
    sign_in @admin
    assert_difference 'User.count', -1 do
      delete admin_destroy_user_path(@user)
    end
  end

  test "admin_edit works" do
    sign_in @admin
    get admin_edit_user_path(@user.id)
    assert_response :success
    @name=@user.name
    patch admin_patch_user_path(@user), params: {id: @user.id, user: { name: "New name"}}
    @name2=@user.reload.name
    assert_not_equal @name, @name2
  end

  test "Delete Twitter details works" do
    sign_in @twitter
    assert_not_nil @twitter.twitter_key
    get '/twitter_disconnect.html'
    assert_nil @twitter.twitter_key
    assert_nil @twitter.twitter_secret
    assert_nil @twitter.twitter_user_url
    assert_nil @twitter.uid
    assert_nil @twitter.provider
  end
end
