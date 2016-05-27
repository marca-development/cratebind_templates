# Angular Templates

## Installation

Add the gem to your Gemfile
```
group :development do
	gem 'cratebind_templates', git: 'https://git.cratebind.com/open-source/cratebind_templates.git'
end
```

and then run bundle update.

## Generators

The gem has five (5) generators:

1. cratebind:controller NAME
	- generates Api::ResourceController template following our standard practice
	- generates Api::NamesController which inherits from ResourceController
	- assumes you are working with an api in the api namespace
	- assumes you are protecting the api with ```:authenticate_user!``` and using cancancan for authorization
2. cratebind:routes NAME
	- generates ```resources :names``` in the :api namespace
	- generates ```patch '/names', to: 'names#index'``` so that you can patch to Ransack on the index from Angular
3. cratebind:views NAME
	- generates the standard json jbuilders in /app/views/api/names directory (partial, index and show)
	- uses a partial and will include all columns in the database
4. cratebind:angular NAME
	- will ask for the namespace (i.e. admin)
	- generates a factory in app/assets/javascripts/namespace/angular/factories/names.js
	- adds the routing to app/assets/javascripts/namespace/angular/routing.js
	- generates a standard Angular resource controller in app/assets/javascripts/namespace/angular/controllers/names.js
	- assumes the Angular app is named ```namespaceApp```
5. cratebind:resource NAME
	- runs all of the above

## Usage
A typical use case would be the following

```
rails g model order name:string amount:decimal
rake db:migrate
rails g cratebind:resource order
```