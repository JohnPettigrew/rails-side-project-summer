require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @project = @user.projects.build(name: "Project", description: "Lorem ipsum", source: "http://github.com")
  end

  test "Project should be valid" do
    assert @project.valid?
  end

  test "User_id should be present" do
    @project.user_id = nil
    assert_not @project.valid?
  end

  test "Description should be present" do
    @project.description = "   "
    assert_not @project.valid?
  end

  test "Description should be at most 280 characters" do
    @project.description = "a" * 281
    assert_not @project.valid?
  end

  test "Order should be most recent first" do
    assert_equal projects(:most_recent), Project.first
  end
end
