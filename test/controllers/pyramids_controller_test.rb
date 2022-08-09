require 'test_helper'

class PyramidsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pyramid = pyramids(:one)
  end

  test "should get index" do
    get pyramids_url
    assert_response :success
  end

  test "should get new" do
    get new_pyramid_url
    assert_response :success
  end

  test "should create pyramid" do
    assert_difference('Pyramid.count') do
      post pyramids_url, params: { pyramid: { name: @pyramid.name, public_flag: @pyramid.public_flag, technology_id: @pyramid.technology_id } }
    end

    assert_redirected_to pyramid_url(Pyramid.last)
  end

  test "should show pyramid" do
    get pyramid_url(@pyramid)
    assert_response :success
  end

  test "should get edit" do
    get edit_pyramid_url(@pyramid)
    assert_response :success
  end

  test "should update pyramid" do
    patch pyramid_url(@pyramid), params: { pyramid: { name: @pyramid.name, public_flag: @pyramid.public_flag, technology_id: @pyramid.technology_id } }
    assert_redirected_to pyramid_url(@pyramid)
  end

  test "should destroy pyramid" do
    assert_difference('Pyramid.count', -1) do
      delete pyramid_url(@pyramid)
    end

    assert_redirected_to pyramids_url
  end
end
