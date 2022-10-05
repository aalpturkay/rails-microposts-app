require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:testuser)
    end

    test "login with valid information followed by logout" do
        get login_path
        post login_path, params: { session: { email: @user.email, password: 'password' } }
        assert is_logged_in?
        assert_redirected_to @user
        follow_redirect!
        assert_template 'users/show'
        delete logout_path
        assert_not is_logged_in?
        assert_redirected_to root_path
        # Simulate a user clicking logout in a second window.
        delete logout_path
        follow_redirect!
    end
end