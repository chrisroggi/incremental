require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should login with corrent credentials" do
    post "#{ users_url }/login",
      params: { username: 'incre', password: 'mental' },
      as: :json
    assert_response :success
  end

  test "should not login with incorrent credentials" do
    post "#{ users_url }/login",
      params: { username: 'james', password: 'bond' },
      as: :json
    assert_response :unauthorized
  end
end
