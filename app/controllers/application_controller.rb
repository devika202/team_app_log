class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include MultiTenantConcern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :capture_user_behavior
  def get_cumulative_inactive_time
    cumulative_inactive_time = calculate_cumulative_inactive_time

    render json: { cumulative_inactive_time: cumulative_inactive_time }
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  private

  def capture_user_behavior
    if user_signed_in?
      UserBehavior.create(user_id: current_user.id, page_name: request.fullpath, timestamp: Time.now)
    end
  end

  
  def calculate_cumulative_inactive_time
    user = current_user
    user_behaviors = UserBehavior.where(user_id: user.id)
    cumulative_inactive_time = user_behaviors.sum(:inactive_time_in_milliseconds)
    
    cumulative_inactive_time
  end
  
  
end
