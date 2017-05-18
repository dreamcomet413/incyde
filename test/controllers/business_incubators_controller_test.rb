require 'test_helper'

class BusinessIncubatorsControllerTest < ActionController::TestCase
  setup do
    @business_incubator = business_incubators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_incubators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_incubator" do
    assert_difference('BusinessIncubator.count') do
      post :create, business_incubator: { address: @business_incubator.address, avatar: @business_incubator.avatar, city: @business_incubator.city, country: @business_incubator.country, name: @business_incubator.name, phone: @business_incubator.phone, province: @business_incubator.province, web: @business_incubator.web }
    end

    assert_redirected_to business_incubator_path(assigns(:business_incubator))
  end

  test "should show business_incubator" do
    get :show, id: @business_incubator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_incubator
    assert_response :success
  end

  test "should update business_incubator" do
    patch :update, id: @business_incubator, business_incubator: { address: @business_incubator.address, avatar: @business_incubator.avatar, city: @business_incubator.city, country: @business_incubator.country, name: @business_incubator.name, phone: @business_incubator.phone, province: @business_incubator.province, web: @business_incubator.web }
    assert_redirected_to business_incubator_path(assigns(:business_incubator))
  end

  test "should destroy business_incubator" do
    assert_difference('BusinessIncubator.count', -1) do
      delete :destroy, id: @business_incubator
    end

    assert_redirected_to business_incubators_path
  end
end
