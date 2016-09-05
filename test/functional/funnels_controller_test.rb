require 'test_helper'

class FunnelsControllerTest < ActionController::TestCase
  setup do
    @funnel = funnels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:funnels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create funnel" do
    assert_difference('Funnel.count') do
      post :create, funnel: {  }
    end

    assert_redirected_to funnel_path(assigns(:funnel))
  end

  test "should show funnel" do
    get :show, id: @funnel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @funnel
    assert_response :success
  end

  test "should update funnel" do
    put :update, id: @funnel, funnel: {  }
    assert_redirected_to funnel_path(assigns(:funnel))
  end

  test "should destroy funnel" do
    assert_difference('Funnel.count', -1) do
      delete :destroy, id: @funnel
    end

    assert_redirected_to funnels_path
  end
end
