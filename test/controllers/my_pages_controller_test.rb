require 'test_helper'

class MyPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_page = my_pages(:one)
  end

  test 'should get index' do
    get my_pages_url
    assert_response :success
  end

  test 'should get new' do
    get new_my_page_url
    assert_response :success
  end

  test 'should create my_page' do
    assert_difference('User.count') do
      post my_pages_url, params: { my_page: {} }
    end

    assert_redirected_to my_page_url(User.last)
  end

  test 'should show my_page' do
    get my_page_url(@my_page)
    assert_response :success
  end

  test 'should get edit' do
    get edit_my_page_url(@my_page)
    assert_response :success
  end

  test 'should update my_page' do
    patch my_page_url(@my_page), params: { my_page: {} }
    assert_redirected_to my_page_url(@my_page)
  end

  test 'should destroy my_page' do
    assert_difference('User.count', -1) do
      delete my_page_url(@my_page)
    end

    assert_redirected_to my_pages_url
  end
end
