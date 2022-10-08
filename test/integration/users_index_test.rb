require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:galadriel)
  end

  test "index including pagination" do
    login_as(@user)
    get users_path
    assert_template 'users/index'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
