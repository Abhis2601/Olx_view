class CategoriesController < ApplicationController
	
	def index
	end

	def particular_category_products
		@category_products = Product.joins(:category).available.merge(Category.where(id:params[:id]))
		@category = Category.find_by(id:params[:id])
	end
end
