	class Api::OrderController < Api::ResourceController
		wrap_parameters :order, include: [:name, :created_at, :updated_at]
		load_and_authorize_resource class: Order

		private

		def set_klass
			@klass = Order
		end

		def includes_array
			[]
		end

		def set_current_user
			false
		end

		def resource_params
			params.require(:order).permit(:name, :created_at, :updated_at)
		end  
	end
