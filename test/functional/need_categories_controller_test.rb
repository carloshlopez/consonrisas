require 'test_helper'

class NeedCategoriesControllerTest < ActionController::TestCase
  setup do
    @need_category = need_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:need_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create need_category" do
    assert_difference('NeedCategory.count') do
      post :create, :need_category => @need_category.attributes
    end

    assert_redirected_to need_category_path(assigns(:need_category))
  end

  test "should show need_category" do
    get :show, :id => @need_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @need_category.to_param
    assert_response :success
  end

  test "should update need_category" do
    put :update, :id => @need_category.to_param, :need_category => @need_category.attributes
    assert_redirected_to need_category_path(assigns(:need_category))
  end

  test "should destroy need_category" do
    assert_difference('NeedCategory.count', -1) do
      delete :destroy, :id => @need_category.to_param
    end

    assert_redirected_to need_categories_path
  end
end
