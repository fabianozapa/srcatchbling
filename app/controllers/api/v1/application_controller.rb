module Api
  module V1
    class ApplicationController < ::ActionController::API
      attr_reader :current_user, :current_ability

      prepend_before_action :auth_user

      rescue_from ActiveRecord::RecordNotFound do |e|
        render status: :not_found, json: e&.message&.as_json
      end

    private

      def token
        headers['token'] || headers['Token']
      end

      def auth_user
        @current_user ||= User.find_by(api_token: token)
        @current_ability ||= Ability.new(current_user)
      rescue
        render status: :unauthorized
      end

      def page
        params.try(:[], :page) || 1
      end

      def per_page
        params.try(:[], :per_page) || 10
      end
    end
  end
end
