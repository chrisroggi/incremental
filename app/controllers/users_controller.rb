class UsersController < ApplicationController

  def login
    user = User.stub( username: params[ :username ] )

    if user.present? && user.authenticate( params[ :password ] )
      token = JsonWebToken.encode( username: user.username )
      render json: { token: token }, status: :ok
    else
      render json: { errors: [ 'Invalid username or password' ] }, status: :unauthorized
    end
  end

end