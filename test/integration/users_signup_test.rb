require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
  end
  # assert_template 'users/new'
  # assert_select 'div#<CSS id for error explanation>'
  # assert_select 'div.<CSS class for field with error>'
  follow_redirect!
  assert_template 'users/show'
  assert is_logged_in?
  # assert_not flash.FILL_IN

# test "the truth" do
#   assert true
  end
end
