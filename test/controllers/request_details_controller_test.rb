require 'test_helper'

class RequestDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get request_details_index_url
    assert_response :success
  end

end
