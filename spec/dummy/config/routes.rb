Rails.application.routes.draw do

	namespace :api do
		resources :orders
		patch '/orders', to: 'orders#index'
	end

  
end