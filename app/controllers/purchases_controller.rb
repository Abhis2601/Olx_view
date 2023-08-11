class PurchasesController < ApplicationController
		load_and_authorize_resource 

	def new

	end

	def buy
		# @purchase = Purchase.new(user_id:@current_user.id, product_id:params[:id])
		product = Product.available.find_by(id:params[:id]).accessible_by(current_ability)
		purchase = @current_user.purchases.new(product_id: product.id)
	 	purchase.save
		product.sold!
		
			# render html: helpers.tag.strong("product buy sucessfully...")	
	end
	
	def current_user_sold_products
		@purchases = @current_user.products.sold 
	end

end
