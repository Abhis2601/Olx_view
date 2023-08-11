class ProductsController < ApplicationController
	load_and_authorize_resource 

	def new
	end

	def create
		product = @current_user.products.new(product_params)
		if product.save
			product.alphanumeric_id = generate_alphanumeric(params[:name])
			product.available!
			redirect_to products_path
		else
			render 'new'
		end
	end

	def index
		# @products = Product.all
 	@products =	if params[:name].present?		 
									Product.available.where("name like ?","%#{params[:name]}%")
						    elsif params[:alphanumeric_id].present?
						    	Product.available.where("alphanumeric_id like ?","%#{params[:alphanumeric_id]}%")
						    elsif params[:category_name].present?
					  	  	Product.joins(:category).available.merge(Category.where("category_name like ?","%#{params[:category_name]}%"))
						    else
						    	Product.available
								end		

	end

	def current_user_products
		@products = @current_user.products.available
	end

	private

	def generate_alphanumeric(value)
		random_num = rand(1000)
	 	data = value + "#{random_num}"
	 	return data
	end
	
	def product_params
		params.permit(:name, :description, :price,  :category_id, :product_profile)
	end
end
