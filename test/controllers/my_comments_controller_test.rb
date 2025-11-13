require "test_helper"

class MyCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_comments_index_url
    assert_response :success
  end

  test "should get update" do
    get my_comments_update_url
    assert_response :success
  end

  test "should get delete" do
    get my_comments_delete_url
    assert_response :success
  end
end
