require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
      password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should not be valid when a not valid email entered" do
    @user.email = "foo@invalid"
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a min length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "name should contain maximum 50 characters" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should contain max 255 characters" do
    @user.email = "a" * 255 + "@test.com"
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "when user destroyed associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    galadriel = users(:galadriel)
    testuser = users(:testuser)
    assert_not galadriel.following?(testuser)
    galadriel.follow(testuser)
    assert galadriel.following?(testuser)
    assert testuser.followers.include?(galadriel)
    galadriel.unfollow(testuser)
    assert_not galadriel.following?(testuser)
  end

  test "feed should have the right posts" do
    testuser = users(:testuser)
    galadriel = users(:galadriel)
    isildur = users(:isildur)

    galadriel.microposts.each do |post_following|
      assert testuser.feed.include?(post_following)
    end

    testuser.microposts.each do |post_self|
      assert testuser.feed.include?(post_self)
    end

    isildur.microposts.each do |post_unfollowed|
      assert_not testuser.feed.include?(post_unfollowed)
    end
  end
end
