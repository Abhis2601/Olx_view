class ApplicationController < ActionController::Base
  include JsonWebToken
  before_action :authenticate_user

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "You can not access"
    # redirect_to :back
  end
rescue_from ActiveRecord::RecordNotFound do |exception|
   flash[:notice] = "You can not access"
    # redirect_to :back
 end
  def current_user
    @current_user
  end

  def authenticate_user
    begin
      decoded = jwt_decode(session[:current_user].split(' ').last)
      @current_user = User.find_by_email(decoded[:email])
      raise unless @current_user.present?
    rescue StandardError
      flash[:notice] = "Unauthorize User"
      redirect_to signin_users_path
     # render html: helpers.tag.strong('Unauthorized')
    end
  end
end
