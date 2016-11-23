class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private 

  def user_not_authorized(exception) 
    policy_name = exception.policy.class.to_s.underscore
    message = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    flash[:alert] = message
    respond_to do |format| 
      format.html { redirect_to(request.referrer || root_path) }
      format.json { render json: messsage, status: :unauthorized }
    end
  end
end
