class UsersController < ApplicationController
	skip_before_action :require_login
	def new
		user = User.new
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:current_user_id] = user.id
			redirect_to products_path
		else
			render 'new'
		end
	end
	def login
		debugger
		user = User.find_by(email: params[:email])
		if user.password == params[:password]
			session[:current_user_id] = user.id 
			redirect_to products_path
		else
			render 'new'
		end
	end
	def destroy
    # Remove the user id from the session
    debugger
    session.delete(:current_user_id)
    # Clear the memoized current user
    @current_user = nil
    redirect_to new_users_path
  end

	private

	def user_params
		params.permit(:first_name, :last_name, :email, :mobile_no, :password)
	end
end
