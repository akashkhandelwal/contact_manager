require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe '' do
	describe 'the person view', type: :feature do

		let(:person) { Fabricate :person }
		let(:user) { person.user }

		before(:each) do
		  person.phone_numbers.create(number: "555-1234")
		  person.phone_numbers.create(number: "555-5678")
		  login_as(user)
		  visit person_path(person)
		end


		it 'shows phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_content(phone.number)
			end
		end

		it 'has a link to add new phone number' do
			expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: person.id, contact_type: 'Person'))
		end

		it 'adds a new phone number' do
			page.click_link('Add phone number')
			page.fill_in('Number', with: '555-1234')
			page.click_button('Create Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('555-1234')
		end

		it 'has links to edit phone numbers' do
	  	person.phone_numbers.each do |phone|
	    	expect(page).to have_link('Edit', href: edit_phone_number_path(phone))
	  	end
		end

		it 'edits the phone number' do
			phone = person.phone_numbers.first
		  old_number = phone.number

		  page.click_link('Edit')
		  page.fill_in('Number', with: '555-9191')
		  page.click_button('Update Phone number')
		  expect(current_path).to eq(person_path(person))
		  expect(page).to have_content('555-9191')
		  expect(page).to_not have_content(old_number)
		end

		it 'has a link to delete the phone number' do
			person.phone_numbers.each do |phone|
				expect(page).to have_link('Delete', href: "/phone_numbers/#{phone.id}", method: :delete)
			end
		end

		it 'deletes the phone number' do
			phone = person.phone_numbers.first
			old_number = phone.number

			page.click_link('Delete')
			expect(current_path).to eq(person_path(person))
			expect(page).to_not have_content(old_number)
			expect(page).to_not have_link("Delete", href: "/phone_numbers/#{phone.id}", method: :delete)
		end
	end 	
end

describe "" do
	describe "the email view" do
		
		let(:person) { Fabricate :person }
		let(:user) { person.user }

		before(:each) do
		  person.email_addresses.create(address: 'one@example.com')
		  person.email_addresses.create(address: 'two@example.com')
		  login_as(user)
		  visit person_path(person)
		end


		it 'shows email address' do
			person.email_addresses.each do |email|
				expect(page).to have_selector('li', text: email.address)
			end
		end

		it 'has add email address link' do
			expect(page).to have_link('Add email id', href: new_email_address_path(contact_id: person.id, contact_type: 'Person'))
		end

		it 'adds a new email address' do
			page.click_link('Add email id')
			page.fill_in('Address', with: 'akash@jombay.com')
			page.click_button('Create Email address')
			expect(current_path).to eql(person_path(person))
			expect(page).to have_content('akash@jombay.com')
		end

		it 'has a link to edit email address' do
			person.email_addresses.each do |email|
				expect(page).to have_link('Edit', href: edit_email_address_path(email))
			end
		end

		it 'edits the email address' do
			email = person.email_addresses.first
			old_address = email.address

			page.click_link('Edit')
			page.fill_in('Address', with: 'akash1@jombay.com')
			page.click_button('Update Email address')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('akash1@jombay.com')
			expect(page).to_not have_content(old_address)
		end

		it 'has a link to delete email address' do
			person.email_addresses.each do |email|
				expect(page).to have_link('Delete', href: "/email_addresses/#{email.id}", method: :delete)
			end
		end

		it 'deletes the email address' do
			address = person.email_addresses.first.address

			page.click_link('Delete')
			expect(current_path).to eq(person_path(person))
			expect(page).to_not have_content(address)
		end
	end
end

