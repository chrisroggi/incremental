module RequiresAuthenticationFilter

  class RequiresAuthentication

    def before( controller )
      user = User.stub( username: username( controller.request ) )

      if user.blank?
        controller.render json: { errors: [ 'Unauthorized' ] }, status: :unauthorized
      end
    end

    private

    def username( request )
      auth_header = request.headers[ 'Authorization' ]
      token = auth_header.split( ' ' ).last
      payload = JsonWebToken.decode( token )

      payload[ 'username' ]
    rescue
      nil
    end

  end

  module ClassMethods

    def requires_authentication( options = {} )
      before_action( RequiresAuthentication.new, options )
    end

  end

  def self.included( controller )
    controller.extend( ClassMethods )
  end

end