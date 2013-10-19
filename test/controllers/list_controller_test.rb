require 'test_helper'

class ListControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get getdata" do
    get :getdata
    assert_response :success
  end

end
