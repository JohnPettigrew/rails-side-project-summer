require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:three)
  end

  test "Associated projects should be destroyed" do
    @user.save
    @user.projects.create!(name: "Project", description: "Lorem ipsum", source: "http://github.com")
    assert_difference 'Project.count', -1 do
      @user.destroy
    end
  end
end
