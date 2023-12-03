class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
      root_path
    end

    def after_sign_out_path_for(resource_or_scope)
      request.referrer
    end

    # For nginx cache
    def set_cookie
      if cookies[:auth]
        cookies[:auth] = { :value => "1", :expires => Time.now + 7200 }
      end
    end

    def check_session
      unless user_signed_in?
        redirect_to new_user_session_url
      end
    end
end
