require 'test_helper'

class PopulationsControllerTest < ActionController::TestCase
  setup do
    @population = populations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:populations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create population" do
    assert_difference('Population.count') do
      post :create, :population => @population.attributes
    end

    assert_redirected_to population_path(assigns(:population))
  end

  test "should show population" do
    get :show, :id => @population.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @population.to_param
    assert_response :success
  end

  test "should update population" do
    put :update, :id => @population.to_param, :population => @population.attributes
    assert_redirected_to population_path(assigns(:population))
  end

  test "should destroy population" do
    assert_difference('Population.count', -1) do
      delete :destroy, :id => @population.to_param
    end

    assert_redirected_to populations_path
  end
end
