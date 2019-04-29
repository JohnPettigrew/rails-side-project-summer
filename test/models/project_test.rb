require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @project = @user.projects.build(name: "Project", description: "Lorem ipsum", source: "http://github.com")
  end

  test "Project should be valid" do
    assert @project.valid?
  end

  test "User should be present for project" do
    @project.user = nil
    assert_not @project.valid?
  end

  test "Description should be present" do
    @project.description = "   "
    assert_not @project.valid?
  end

  test "Description should be at most 1500 characters" do
    @project.description = "a" * 1501
    assert_not @project.valid?
  end

  test "Order should be most recent first" do
    assert_equal projects(:most_recent), Project.first
  end
end
