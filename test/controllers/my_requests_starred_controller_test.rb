require 'test_helper'

class MyRequestsStarredControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_requests_starred_index_url
    assert_response :success
  end

end
