class ApplicationController < ActionController::Base
    before_action :current_user
    # helper_method :require_user
    def require_user
        if !@_current_user
            flash[:notice] = "Log in first!"
            redirect_to login_path 
        end
    end
    
    private
    def current_user
      @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end
    
end
