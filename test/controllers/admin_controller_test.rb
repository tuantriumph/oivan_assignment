require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get users" do
    get admin_users_url
    assert_response :success
  end

  test "should get tests" do
    get admin_tests_url
    assert_response :success
  end

  test "should get new_user" do
    get admin_new_user_url
    assert_response :success
  end

  test "should get create_user" do
    get admin_create_user_url
    assert_response :success
  end

  test "should get edit_user" do
    get admin_edit_user_url
    assert_response :success
  end

  test "should get save_user" do
    get admin_save_user_url
    assert_response :success
  end
end
