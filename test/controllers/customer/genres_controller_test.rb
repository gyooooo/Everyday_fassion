require "test_helper"

class Customer::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get customer_genres_show_url
    assert_response :success
  end
end
