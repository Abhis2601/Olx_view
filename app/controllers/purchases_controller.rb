class PurchasesController < ApplicationController
	def new
		@purchase = Purchase.new
	end

	def create
		@purchase = Purchase.new()
	end
end
