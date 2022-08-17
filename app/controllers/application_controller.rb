class ApplicationController < ActionController::Base
#    before_action :authenticate_customer!, except: [:top, :about]
    before_action :configure_permitted_parameters,if: :devise_controller?
    # before_action :authenticate_customer!
    
  def after_sign_up_path_for(resource)
    root_path(current_customer)
  end
  
  def after_sign_in_path_for(resource)
    root_path(current_customer)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
    
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :nickname])
    end
end
