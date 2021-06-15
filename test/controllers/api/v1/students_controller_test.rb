require "test_helper"

class Api::V1::StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get api_v1_students_login_url
    assert_response :success
  end

  test "should get logout" do
    get api_v1_students_logout_url
    assert_response :success
  end

  test "should get all_tests" do
    get api_v1_students_all_tests_url
    assert_response :success
  end

  test "should get get_test" do
    get api_v1_students_get_test_url
    assert_response :success
  end

  test "should get save_test" do
    get api_v1_students_save_test_url
    assert_response :success
  end
end
