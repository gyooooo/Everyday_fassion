require "test_helper"

class Customer::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_favorites_index_url
    assert_response :success
  end
end
