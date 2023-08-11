class UsersController < ApplicationController
	skip_before_action :authenticate_user, only:[:new,:login,:create,:signin]
  include JsonWebToken
	def new
	end

	def create
		@user = User.new(user_params)
		if @user.save
      session[:current_user] = jwt_encode(email: @user.email)
			redirect_to products_path
		else
			render 'new'
		end
	end

	def login
    @user = User.find_by(email: params[:email])   
    if  @user.password == params[:password]
      session[:current_user] = jwt_encode(email: @user.email)
      redirect_to products_path
    else
      flash[:notice] = "Unauthorize User"
      redirect_to signin_users_path
    end
  
  end

	def destroy
    # Remove the user id from the session
    session.delete(:current_user)
    # Clear the memoized current user
    @current_user = nil
    redirect_to new_users_path
  end

  def signin
  end
  
	private

	def user_params
		params.permit(:first_name, :last_name, :email, :mobile_no, :password)
	end
end
