describe '' do
	describe 'the contact view', type: :feature do

		let(:company) { Company.create(name: "Akash") }

		before(:each) do
			company.phone_numbers.create(number: "555-1234")
			company.phone_numbers.create(number: "555-9786")
			visit company_path(company)
		end

		it 'shows phone numbers' do
			company.phone_numbers.each do |phone|
				expect(page).to have_content(phone.number)
			end
		end

		it 'has a link to add new phone number' do
			expect(page).to have_link('Add Phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
		end

		it 'adds a new phone number' do
			page.click_link('Add Phone number')
			page.fill_in('Number', with: '555-1234')
			page.click_button('Create Phone number')
			expect(current_path).to eq(company_path(company))
			expect(page).to have_content('555-1234')
		end

		it 'has links to edit phone numbers' do
	  	company.phone_numbers.each do |phone|
	    	expect(page).to have_link('Edit', href: edit_phone_number_path(phone))
	  	end
		end

		it 'edits the phone number' do
			phone = company.phone_numbers.first
		  old_number = phone.number

		  page.click_link('Edit')
		  page.fill_in('Number', with: '555-9191')
		  page.click_button('Update Phone number')
		  expect(current_path).to eq(company_path(company))
		  expect(page).to have_content('555-9191')
		  expect(page).to_not have_content(old_number)
		end

		it 'has a link to delete the phone number' do
			company.phone_numbers.each do |phone|
				expect(page).to have_link('Delete', href: "/phone_numbers/#{phone.id}", method: :delete)
			end
		end

		it 'deletes the phone number' do
			phone = company.phone_numbers.first
			old_number = phone.number

			page.click_link('Delete')
			expect(current_path).to eq(company_path(company))
			expect(page).to_not have_content(old_number)
			expect(page).to_not have_link("Delete", href: "/phone_numbers/#{phone.id}", method: :delete)
		end
	end 	
end