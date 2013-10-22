require 'test_helper'

class DatapagesControllerTest < ActionController::TestCase
  setup do
    @datapage = datapages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:datapages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create datapage" do
    assert_difference('Datapage.count') do
      post :create, datapage: { html: @datapage.html, url: @datapage.url }
    end

    assert_redirected_to datapage_path(assigns(:datapage))
  end

  test "should show datapage" do
    get :show, id: @datapage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @datapage
    assert_response :success
  end

  test "should update datapage" do
    patch :update, id: @datapage, datapage: { html: @datapage.html, url: @datapage.url }
    assert_redirected_to datapage_path(assigns(:datapage))
  end

  test "should destroy datapage" do
    assert_difference('Datapage.count', -1) do
      delete :destroy, id: @datapage
    end

    assert_redirected_to datapages_path
  end
end
