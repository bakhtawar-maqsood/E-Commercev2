# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get all_products' do
    get home_all_products_url
    assert_response :success
  end
end
