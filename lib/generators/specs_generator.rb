##
# Creates the routes, controllers and jbuilder views for an api resource
# usage: rails g cratebind:controllers NAME 
module Cratebind
	class SpecsGenerator < Rails::Generators::NamedBase
	  	# source_root File.expand_path("../templates", __FILE__)

		def create_controller_spec
			columns = class_name.constantize.column_names.collect(&:to_sym)
			columns.delete(:id)
			model_name = class_name.downcase
			columns = columns.to_s.gsub('[','').gsub(']','')
			create_file "spec/controllers/api/#{plural_name}_controller_spec.rb", <<-FILE
require 'rails_helper'
describe Api::#{class_name.pluralize}Controller, type: :controller do
  render_views

  let(:json)        { JSON.parse(response.body) }
  let(:#{model_name})     { create(:#{model_name}) }
  let(:valid_attributes) {
    {  }
  }

  let(:invalid_attributes) {
    {  }
  }

  let(:new_attributes) {
    {  }
  }

  let(:valid_session) {}

  describe "GET #index" do

    it "assigns all #{model_name.pluralize} as @resources" do
      #{model_name}
      get :index, {}, valid_session
      expect(assigns(:resources)).to eq([#{model_name}])
    end

    it 'should be able to filter by q' do
      #{model_name} = create(:edge_#{model_name}, name: 'Weird')
      get :index, {q: {name_cont: 'Weird'}}, valid_session
      expect(assigns(:resources)).to eq([#{model_name}])
    end

    it 'should be able to download a csv' do
      #{model_name} = create(:edge_#{model_name}, name: 'CSV')
      get :index, {q: {name_cont: #{model_name}.name}, format: :csv}, valid_session
      expect(assigns(:resources)).to eq([#{model_name}])        
    end

    it 'should be unauthorized unless signed in' do
      get :index, {}
      #autenthicate user redirects
      expect(response.status).to eq(302)
    end

  end

  describe "GET #show" do
    it "assigns the requested #{model_name} as @#{model_name}" do
      #{model_name}
      get :show, {:id => #{model_name}.to_param}, valid_session
      expect(assigns(:#{model_name})).to eq(#{model_name})
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new #{class_name}" do
        expect {
          post :create, {:#{model_name} => valid_attributes}, valid_session
        }.to change(#{class_name}, :count).by(1)
      end

      it "assigns a newly created #{model_name} as @#{model_name}" do
        post :create, {:#{model_name} => valid_attributes}, valid_session
        expect(assigns(:#{model_name})).to be_a(#{class_name})
        expect(assigns(:resource)).to be_persisted
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do

      it "re-renders the 'new' template" do
        post :create, {:#{model_name} => invalid_attributes}, valid_session
        expect(assigns(:#{model_name})).to be_a_new(#{class_name})
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do

      it "updates the requested #{model_name}" do
        #{model_name}
        put :update, {:id => #{model_name}.to_param, :#{model_name} => new_attributes}, valid_session
        #{model_name}.reload
        expect(#{model_name}.name).to eq('')
        expect(assigns(:#{model_name})).to eq(#{model_name})
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      it "assigns the #{model_name} as @#{model_name}" do
        #{model_name}
        put :update, {:id => #{model_name}.to_param, :#{model_name} => invalid_attributes}, valid_session
        expect(assigns(:#{model_name})).to eq(#{model_name})
        expect(response.status).to eq(422)
      end

    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested #{model_name}" do
      #{model_name}
      expect {
        delete :destroy, {:id => #{model_name}.to_param}, valid_session
      }.to change(#{class_name}, :count).by(-1)
    end
  end
end

	    	FILE
		end

	end
end