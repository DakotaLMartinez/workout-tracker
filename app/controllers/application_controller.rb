class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private 

  def user_not_authorized(exception) 
    message = "You are not authorized to perform that action"
    if exception.respond_to?(:policy)
      policy_name = exception.policy.class.to_s.underscore 
      message = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    end
    flash[:alert] = message
    respond_to do |format| 
      format.html { redirect_to(request.referrer || root_path) }
      format.json { render json: messsage, status: :unauthorized }
    end
  end
end
