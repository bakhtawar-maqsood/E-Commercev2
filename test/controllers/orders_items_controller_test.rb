# frozen_string_literal: true

require 'test_helper'

class OrdersItemsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get orders_items_new_url
    assert_response :success
  end

  test 'should get edit' do
    get orders_items_edit_url
    assert_response :success
  end

  test 'should get update' do
    get orders_items_update_url
    assert_response :success
  end

  test 'should get show' do
    get orders_items_show_url
    assert_response :success
  end
end
