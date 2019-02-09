require 'test_helper'

class CountControllerTest < ActionDispatch::IntegrationTest
  setup do
    post "#{ users_url }/login",
      params: { username: 'incre', password: 'mental' },
      as: :json
    response_body = JSON.parse( response.body )
    @token = response_body[ 'token' ]
  end

  test "should increment count times two if count is greater than zero" do
    get "#{ count_url }/increment?count=4",
      params: {},
      headers: { 'Authorization' => @token }

    response_body = JSON.parse( response.body )

    assert_equal( response_body[ 'count' ], 8 )
    assert_response :success
  end

  test "should increment count to one if count is less than one" do
    get "#{ count_url }/increment?count=-4",
      params: {},
      headers: { 'Authorization' => @token }

    response_body = JSON.parse( response.body )

    assert_equal( response_body[ 'count' ], 1 )
    assert_response :success
  end
end
