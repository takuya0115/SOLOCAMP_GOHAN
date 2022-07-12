require "test_helper"

class Users::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get users_homes_top_url
    assert_response :success
  end
end
