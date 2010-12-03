require 'test_helper'

class ProvidersControllerTest < ActionController::TestCase
  setup do
    @provider = providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provider" do
    assert_difference('Provider.count') do
      post :create, :provider => @provider.attributes
    end

    assert_redirected_to provider_path(assigns(:provider))
  end

  test "should show provider" do
    get :show, :id => @provider.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @provider.to_param
    assert_response :success
  end

  test "should update provider" do
    put :update, :id => @provider.to_param, :provider => @provider.attributes
    assert_redirected_to provider_path(assigns(:provider))
  end

  test "should destroy provider" do
    assert_difference('Provider.count', -1) do
      delete :destroy, :id => @provider.to_param
    end

    assert_redirected_to providers_path
  end
end
