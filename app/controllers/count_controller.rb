class CountController < ApplicationController

  requires_authentication

  def increment
    count =
      begin
        Integer( params[ :count ] )
      rescue ArgumentError
        Float( params[ :count ] ) rescue nil
      end

    if count.present?
      count = count > 0 ? count * 2 : 1
      render json: { count: count }, status: :ok
    else
      render json: { errors: [ 'Invalid count parameter' ] }, status: :bad_request
    end
  end

end