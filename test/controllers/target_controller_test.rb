require "test_helper"

class TargetControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get target_index_url
    assert_response :success
  end
end
