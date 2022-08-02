require "test_helper"

class Customer::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get customer_customers_new_url
    assert_response :success
  end

  test "should get show" do
    get customer_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get customer_customers_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get customer_customers_unsubscribe_url
    assert_response :success
  end
end
