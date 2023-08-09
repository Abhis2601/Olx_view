class ApplicationController < ActionController::Base
	before_action :current_user , :require_login


  
  
  private

  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end


  def require_login
    if @current_user.present?
      redirect_to signin_users_path
    end
  end
end
