require 'spec_helper'

describe SessionsController do

	before(:each) do
	  Rails.application.routes.draw do
	    resource :sessions, :only => [:create, :destroy]
	    root to: 'site#index'
	  end
	end

	after(:each) do
	  Rails.application.reload_routes!
	end

	describe "create" do
		it "logs in a new user" do
		  @request.env["omniauth.auth"] = {
		    'provider' => 'twitter',
		    'info' => {'name' => 'Alice Smith'},
		    'uid' => 'abc123'
		  }

		  post :create
		  user = User.find_by_uid_and_provider('abc123', 'twitter')
		  expect(controller.current_user.id).to eq(user.id)
		end

		it "logs in an existing user" do
		  @request.env["omniauth.auth"] = {
		    'provider' => 'twitter',
		    'info' => {'name' => 'Bob Jones'},
		    'uid' => 'xyz456'
		  }
		  user = User.create(provider: 'twitter', uid: 'xyz456', name: 'Bob Jones')

		  post :create
		  expect(User.count).to eq(1)
		  expect(controller.current_user.id).to eq(user.id)
		end


		it "redirects to the companies page" do
		  @request.env["omniauth.auth"] = {
		    'provider' => 'twitter',
		    'info' => {'name' => 'Charlie Allen'},
		    'uid' => 'pqr456'
		  }
		  user = User.create(provider: 'twitter', uid: 'pqr456', name: 'Charlie Allen')

		  post :create
		  expect(User.count).to eq(1)
		  expect(response).to redirect_to(root_path)
		end
	end

	describe 'destroy' do
		it 'logs out the user' do
		  delete :destroy
		  expect(User.count).to eq(0)
		end

		it "redirects to the companies page" do
		 	delete :destroy
		  expect(User.count).to eq(0)
		  expect(response).to redirect_to(root_path)
		end
	end
end