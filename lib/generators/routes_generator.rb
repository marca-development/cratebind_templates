##
# Creates the routes, controllers and jbuilder views for an api resource
# usage: rails g cratebind:routes NAME
module Cratebind 
	class RoutesGenerator < Rails::Generators::NamedBase
	  
	  	def create_routes
	  		contents = File.read('config/routes.rb')
	  		unless contents.scan(/namespace :api/).size > 0
	  			insert_into_file 'config/routes.rb', after: "Rails.application.routes.draw do\n" do
"
	namespace :api do
	end
" 
	    		end	  			
	  		end
	  		insert_into_file 'config/routes.rb', after: "namespace :api do\n" do
"		resources :#{plural_name}
		patch '/#{plural_name}', to: '#{plural_name}#index'
" 
	    	end
		end

	end
end