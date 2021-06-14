require "test_helper"

class Admin::TestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_test = admin_tests(:one)
  end

  test "should get index" do
    get admin_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_test_url
    assert_response :success
  end

  test "should create admin_test" do
    assert_difference('Admin::Test.count') do
      post admin_tests_url, params: { admin_test: { desc: @admin_test.desc, name: @admin_test.name } }
    end

    assert_redirected_to admin_test_url(Admin::Test.last)
  end

  test "should show admin_test" do
    get admin_test_url(@admin_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_test_url(@admin_test)
    assert_response :success
  end

  test "should update admin_test" do
    patch admin_test_url(@admin_test), params: { admin_test: { desc: @admin_test.desc, name: @admin_test.name } }
    assert_redirected_to admin_test_url(@admin_test)
  end

  test "should destroy admin_test" do
    assert_difference('Admin::Test.count', -1) do
      delete admin_test_url(@admin_test)
    end

    assert_redirected_to admin_tests_url
  end
end
