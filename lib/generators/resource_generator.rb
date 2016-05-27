##
# Runs the controller, routes, views and angular generators
# usage: rails g cratebind:resource NAME
module Cratebind 
	class ResourceGenerator < Rails::Generators::NamedBase
	  	def create_resource
	  		generate "cratebind:routes", name
	  		generate "cratebind:controllers", name
	  		generate "cratebind:views", name
	  		generate "cratebind:angular", name
	  		generate "cratebind:specs", name
		end
	end
end