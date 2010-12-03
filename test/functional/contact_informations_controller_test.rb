require 'test_helper'

class ContactInformationsControllerTest < ActionController::TestCase
  setup do
    @contact_information = contact_informations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_information" do
    assert_difference('ContactInformation.count') do
      post :create, :contact_information => @contact_information.attributes
    end

    assert_redirected_to contact_information_path(assigns(:contact_information))
  end

  test "should show contact_information" do
    get :show, :id => @contact_information.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @contact_information.to_param
    assert_response :success
  end

  test "should update contact_information" do
    put :update, :id => @contact_information.to_param, :contact_information => @contact_information.attributes
    assert_redirected_to contact_information_path(assigns(:contact_information))
  end

  test "should destroy contact_information" do
    assert_difference('ContactInformation.count', -1) do
      delete :destroy, :id => @contact_information.to_param
    end

    assert_redirected_to contact_informations_path
  end
end
