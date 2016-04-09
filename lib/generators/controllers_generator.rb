##
# Creates the routes, controllers and jbuilder views for an api resource
# usage: rails g cratebind:controllers NAME 
module Cratebind
	class ControllersGenerator < Rails::Generators::NamedBase
	  	source_root File.expand_path("../templates", __FILE__)

	  	def copy_resource_controller
	 		copy_file "resource_controller.rb", "app/controllers/api/resource_controller.rb"
		end

		def create_controller
			columns = class_name.constantize.column_names.collect(&:to_sym)
			columns.delete(:id)
			columns = columns.to_s.gsub('[','').gsub(']','')
			create_file "app/controllers/api/#{plural_name}_controller.rb", <<-FILE
class Api::#{class_name}Controller < Api::ResourceController
	wrap_parameters :#{plural_name.singularize}, include: [#{columns}]
	load_and_authorize_resource class: #{class_name}

	private

	def set_klass
		@klass = #{class_name}
	end

	def includes_array
		[]
	end

	def set_current_user
		false
	end

	def resource_params
		params.require(:#{plural_name.singularize}).permit(#{columns})
	end  
end
	    	FILE
		end

	end
end