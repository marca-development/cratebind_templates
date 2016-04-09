##
# Creates the routes, controllers and jbuilder views for an api resource
# usage: rails g cratebind:views NAME 
module Cratebind
	class ViewsGenerator < Rails::Generators::NamedBase
	  	source_root File.expand_path("../templates", __FILE__)

		def create_partial
			columns = class_name.constantize.column_names.collect(&:to_sym).to_s.gsub('[','').gsub(']','')
			create_file "app/views/api/#{plural_name}/_#{plural_name.singularize}.json.jbuilder", <<-FILE
json.extract! resource, #{columns}
    	FILE
		create_file "app/views/api/#{plural_name}/index.json.jbuilder", <<-FILE
json.partial! '#{plural_name.singularize}', collection: @resources, as: :resource
    	FILE
		create_file "app/views/api/#{plural_name}/show.json.jbuilder", <<-FILE
json.partial! '#{plural_name.singularize}', resource: @resource
	    	FILE
		end

	end
end