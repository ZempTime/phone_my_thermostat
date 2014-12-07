require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get signed_in" do
    get :signed_in
    assert_response :success
  end

  test "should get not_signed_in" do
    get :not_signed_in
    assert_response :success
  end

end
