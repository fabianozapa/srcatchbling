module Admin
  class ApplicationController < ::ApplicationController


    before_action :authenticate_user!
    prepend_before_action :set_globals

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def set_globals
      @current_user = current_user
    end
    
  end
end
