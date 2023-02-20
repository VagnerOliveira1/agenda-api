module Admin::V1
  class ApiController < ApplicationController
    class ForbiddenAccess < StandardError; end
    before_action :cors_set_access_control_headers
    #{}before_action :restrict_access_for_admin!

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

      # include Authenticatable
      
      # include SimpleErrorRenderable
      # self.simple_error_partial = "shared/simple_error"

      # rescue_from ForbiddenAccess do 
      #   render_error(message: "Forbidden access", status: :forbidden)
      # end

      # private

      # def restrict_access_for_admin! 
      #   raise ForbiddenAccess unless current_user.admin? #{}|| current_user.maneger?
      # end
  end
end