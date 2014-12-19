require 'test_helper'

class AddHotelIdToSpecificationsControllerTest < ActionController::TestCase
  test "should get hotel_id:integer" do
    get :hotel_id:integer
    assert_response :success
  end

end
