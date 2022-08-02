require "test_helper"

class Customer::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get customer_comments_new_url
    assert_response :success
  end

  test "should get edit" do
    get customer_comments_edit_url
    assert_response :success
  end
end
